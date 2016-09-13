import Cocoa

class Application: NSObject {

  var name: String = ""
  var icon: NSImage?
  var bundleIdentifier: String = ""
  var udid: String = ""
  var path: NSURL?

  lazy var location: NSURL? = self.loadDataLocation()

  // MARK: - Load

  static func load(path: NSURL) -> [Application] {
    let directory = path.URLByAppendingPathComponent("data/Containers/Bundle/Application")
    return File.directories(directory)
    .map {
      let application = Application()
      application.path = path
      application.loadInfo(directory.URLByAppendingPathComponent($0))

      return application
    }
  }

  // Can also use xcrun simctl get_app_container
  func loadInfo(bundleLocation: NSURL) {
    guard let app = File.directories(bundleLocation).first,
      json = NSDictionary(contentsOfURL: bundleLocation.URLByAppendingPathComponent("\(app)/Info.plist"))
    else { return }

    name = json.string("CFBundleName") ?? ""
    bundleIdentifier = json.string("CFBundleIdentifier") ?? ""
  }

  func loadDataLocation() -> NSURL? {
    guard let path = path else { return nil }
    let directory = path.URLByAppendingPathComponent("data/Containers/Data/Application")

    let plist = ".com.apple.mobile_container_manager.metadata.plist"
    for udid in File.directories(directory) {
      let dataPath = directory.URLByAppendingPathComponent(udid)
      let plistPath = dataPath.URLByAppendingPathComponent(plist)
      guard let json = NSDictionary(contentsOfURL: plistPath)
        else { continue }

      let metaDataIdentifier = json.string("MCMMetadataIdentifier")
      guard metaDataIdentifier == bundleIdentifier else { continue }

      return dataPath
    }


    return nil
  }

  func handleMenuItem(item: NSMenuItem) {
    guard let location = location else { return }
    NSWorkspace.sharedWorkspace().openURL(location)
  }
}