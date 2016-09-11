import Cocoa

class Media {

  var name: String = ""
  var location: NSURL?

  init() {
    
  }

  static func load(path: NSURL) -> [Media] {
    let directory = path.URLByAppendingPathComponent("/data/Media/DCIM")

    return File.directories(directory)
    .map {
      let media = Media()
      media.name = $0.lastPathComponent ?? ""
      media.location = $0

      return media
    }
  }
}