import Cocoa

struct Path {

  static var library: NSURL {
    let path = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true).first ?? ""
    return NSURL(fileURLWithPath: path)
  }

  static var devices: NSURL {
    return library.URLByAppendingPathComponent("Developer/CoreSimulator/Devices")
  }
}
