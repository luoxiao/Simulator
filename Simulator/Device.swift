import Cocoa

class Device {

  var name: String = ""
  var uuid: String = ""
  var os: String = ""
  var version: String = ""
  var isOpen: Bool = false
  var isAvailable: Bool = false

  var applications: [Application] = []
  var appGroups: [AppGroup] = []

  // MARK: - Init

  init() {
    
  }
}