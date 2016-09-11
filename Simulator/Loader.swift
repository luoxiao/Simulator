import Cocoa

class Loader {

  // MARK: - Init

  init() {

  }

  // MARK: - Load

  func load() -> [Device] {
    let string = Task.output("/usr/bin/xcrun", arguments: ["simctl", "list", "-j", "devices"])

    guard let data = string.dataUsingEncoding(NSUTF8StringEncoding),
      jsonObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary,
      json = jsonObject
      else { return [] }

    return parse(json)
  }

  private func parse(json: JSONDictionary) -> [Device] {
    var devices: [Device] = []
    (json["devices"] as? JSONDictionary)?.forEach { (key, value) in
      (value as? JSONArray)?.forEach { deviceJSON in
        let device = Device()
        device.name = deviceJSON.string("name")
        device.uuid = deviceJSON.string("uuid")
        device.isAvailable = deviceJSON.string("availability").containsString("(available)")
        device.isOpen = deviceJSON.string("state").containsString("Booted")
        device.os = key.componentsSeparatedByString(" ").first ?? ""
        device.version = key.componentsSeparatedByString(" ").last ?? ""

        devices.append(device)
      }
    }

    return devices
  }
}
