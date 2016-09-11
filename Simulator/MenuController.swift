import Cocoa

class MenuController: NSObject {

  @IBOutlet var statusMenu: NSMenu!
  let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

  override func awakeFromNib() {
    super.awakeFromNib()

    statusItem.image = NSImage(named: "icon")
    statusItem.menu = statusMenu
    statusItem.action = #selector(statusItemTouched(_:))
  }

  // MARK: - Action

  func statusItemTouched(item: NSStatusItem) {
    print("reload")
  }
}