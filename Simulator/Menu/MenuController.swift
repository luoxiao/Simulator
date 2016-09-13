import Cocoa

class MenuController: NSObject, NSMenuDelegate {

  let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
  var devices: [Device] = []

  override func awakeFromNib() {
    super.awakeFromNib()

    statusItem.image = NSImage(named: "icon")
    statusItem.menu = makeMenu()
  }

  // MARK: - Menu

  func makeMenu() -> NSMenu {
    let menu = NSMenu()
    menu.delegate = self
    menu.autoenablesItems = false

    devices = Device.load()
    Menu.load(devices).forEach {
      menu.addItem($0)
    }

    return menu
  }

  // MARK: - NSMenuDelegate

  func menuWillOpen(menu: NSMenu) {
    statusItem.menu = makeMenu()
  }
}