import Cocoa

struct File {

  static func directories(path: NSURL) -> [NSURL] {
    let results = try? NSFileManager.defaultManager()
      .contentsOfDirectoryAtPath(path.path!)
      .filter {
        return isDirectory($0)
      }.map {
        return NSURL(fileURLWithPath: $0)
      }

    return results ?? []
  }

  static func isDirectory(path: String) -> Bool {
    var flag: ObjCBool =  false
    NSFileManager.defaultManager().fileExistsAtPath(path, isDirectory: &flag)
    return Bool(flag)
  }
}
