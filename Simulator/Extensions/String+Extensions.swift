import Cocoa

extension String {

  func remove(string: String) -> String {
    return stringByReplacingOccurrencesOfString(string, withString: "")
  }
}
