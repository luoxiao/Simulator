import Cocoa

class Device {

  let name: String
  let udid: String
  let osInfo: String
  let isOpen: Bool
  let isAvailable: Bool

  var applications: [Application] = []
  var appGroups: [AppGroup] = []
  var media: [Media] = []

  // MARK: - Init

  init(osInfo: String, json: JSONDictionary) {
    self.name = json.string("name")
    self.udid = json.string("udid")
    self.isAvailable = json.string("availability").containsString("(available)")
    self.isOpen = json.string("state").containsString("Booted")
    self.osInfo = osInfo
    self.applications = Application.load(location)
    self.appGroups = AppGroup.load(location)
    self.media = Media.load(location)
  }

  var location: NSURL {
    return Path.devices.URLByAppendingPathComponent("\(udid)")
  }

  var os: OS {
    return OS(rawValue: osInfo.componentsSeparatedByString(" ").first ?? "") ?? .unknown
  }

  var version: String {
    return osInfo.componentsSeparatedByString(" ").last ?? ""
  }

  var hasContent: Bool {
    return !applications.isEmpty
  }

  // MARK: - Load

  static func load() -> [Device] {
    let string = Task.output("/usr/bin/xcrun", arguments: ["simctl", "list", "-j", "devices"],
                             directoryPath: Path.devices)

    guard let data = string.dataUsingEncoding(NSUTF8StringEncoding),
      jsonObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary,
      json = jsonObject
      else { return [] }

    return parse(json)
  }

  private static func parse(json: JSONDictionary) -> [Device] {
    var devices: [Device] = []
    (json["devices"] as? JSONDictionary)?.forEach { (key, value) in
      (value as? JSONArray)?.forEach { deviceJSON in
        let device = Device(osInfo: key.remove("com.apple.CoreSimulator.SimRuntime."),
                            json: deviceJSON)
        devices.append(device)
      }
    }

    return devices.filter {
      return $0.hasContent && $0.isAvailable && $0.os != .unknown
    }.sort {
      return $0.osInfo.compare($1.osInfo) == .OrderedAscending
    }
  }
}