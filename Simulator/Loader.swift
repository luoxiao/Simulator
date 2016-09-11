import Cocoa

class Loader {

  // MARK: - Init

  init() {

  }

  // MARK: - Load

  func load() -> [Device] {
    let string = Task.output("/usr/bin/xcrun", arguments: ["simctl", "list", "-j", "devices"],
                             directoryPath: Path.devices)

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
        let device = Device(osInfo: key, json: deviceJSON)
        devices.append(device)
      }
    }

    return devices
  }
}
