import Foundation

typealias JSONDictionary = [String: AnyObject]
typealias JSONArray = [JSONDictionary]

extension Dictionary {

  func string(name: String) -> String {
    if let name = name as? Key {
      return self[name] as? String ?? ""
    }

    return ""
  }
}


extension NSDictionary {

  func string(name: String) -> String {
    return self[name] as? String ?? ""
  }
}