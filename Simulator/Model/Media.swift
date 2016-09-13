import Cocoa

class Media: NSObject {

  var name: String = ""
  var location: NSURL?

  // MARK: - Load

  static func load(path: NSURL) -> [Media] {
    let directory = path.URLByAppendingPathComponent("/data/Media/DCIM")

    return File.directories(directory)
    .map {
      let media = Media()
      media.name = $0
      media.location = directory.URLByAppendingPathComponent($0)

      return media
    }
  }

  func handleMenuItem(item: NSMenuItem) {
    guard let location = location else { return }
    NSWorkspace.sharedWorkspace().openURL(location)
  }
}