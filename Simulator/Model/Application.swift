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

      return application
    }
  }

  func handleMenuItem(item: NSMenuItem) {
    guard let location = location else { return }
    NSWorkspace.sharedWorkspace().openURL(location)
  }
}