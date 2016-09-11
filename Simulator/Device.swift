import Cocoa

struct Device {

  var name: String = ""
  var version: String = ""
  var applications: [Application] = []
  var appGroups: [AppGroup] = []

  // MARK: - Init

  init(uuid: String) {
    
  }
}