import Cocoa

class Application {

  var name: String = ""
  var icon: NSImage?
  var bundleIdentifier: String = ""
  var udid: String = ""
  var location: NSURL?

  // MARK: - Init

  init() {
    
  }

  // MARK: - Load

  static func load(path: NSURL) -> [Application] {
    let directory = path.URLByAppendingPathComponent("data/Containers/Bundle/Application")
    return File.directories(directory)
    .map {
      let application = Application()
      application.udid = $0
      application.location = path.URLByAppendingPathComponent($0)

      return application
    }
  }
}