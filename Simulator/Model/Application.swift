import Cocoa

class Application: NSObject {

  var name: String = ""
  var icon: NSImage?
  var bundleIdentifier: String = ""
  var udid: String = ""
  var location: NSURL?

  // MARK: - Load

  static func load(path: NSURL) -> [Application] {
    let directory = path.URLByAppendingPathComponent("data/Containers/Bundle/Application")
    return File.directories(directory)
    .map {
      let application = Application()
      application.udid = $0
      application.location = directory.URLByAppendingPathComponent($0)
      application.loadInfo()

      return application
    }
  }

  func loadInfo() {
    guard let location = location,
      app = File.directories(location).first,
      json = NSDictionary(contentsOfURL: location.URLByAppendingPathComponent("\(app)/Info.plist"))
    else { return }

    name = json.string("CFBundleName") ?? ""
    bundleIdentifier = json.string("CFBundleIdentifier") ?? ""
  }

  func handleMenuItem(item: NSMenuItem) {
    guard let location = location else { return }
    NSWorkspace.sharedWorkspace().openURL(location)
  }
}