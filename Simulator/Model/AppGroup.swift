import Cocoa

class AppGroup {

  var bundleIdentifier: String = ""
  var location: NSURL?
  var udid: String = ""

  // MARK: - Init

  init() {
    
  }

  // MARK: - Load

  static func load(path: NSURL) -> [AppGroup] {
    let directory = path.URLByAppendingPathComponent("/data/Containers/Shared/AppGroup")
    return File.directories(directory)
    .map {
      let appGroup = AppGroup()
      appGroup.location = path.URLByAppendingPathComponent($0)

      let plistPath = appGroup.location!.URLByAppendingPathComponent("/.com.apple.mobile_container_manager.metadata.plist")
      let json = NSDictionary(contentsOfURL: plistPath)

      appGroup.bundleIdentifier = json?.string("MCMMetadataIdentifier") ?? ""
      appGroup.udid = $0


      return appGroup
    }.filter {
      return !$0.bundleIdentifier.containsString("group.com.apple")
    }
  }
}
