import Cocoa

class AppGroup {

  var bundleIdentifier: String = ""
  var location: NSURL?
  var udid: String = ""

  // MARK: - Init

  init() {
    
  }

  static func load(path: NSURL) -> [AppGroup] {
    let directory = path.URLByAppendingPathComponent("/data/Containers/Shared/AppGroup")
    return File.directories(directory)
    .map {
      let plistPath = $0.URLByAppendingPathComponent("/.com.apple.mobile_container_manager.metadata.plist")
      let json = NSDictionary(contentsOfURL: plistPath)

      let appGroup = AppGroup()
      appGroup.bundleIdentifier = json?.string("MCMMetadataIdentifier") ?? ""
      appGroup.udid = $0.lastPathComponent ?? ""
      appGroup.location = $0

      return appGroup
    }.filter {
      return !$0.bundleIdentifier.containsString("group.com.apple")
    }
  }
}
