import Cocoa

class MenuController: NSObject, NSMenuDelegate {

  let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

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

    Menu.load(Device.load()).forEach {
      menu.addItem($0)
    }

    return menu
  }

  // MARK: - NSMenuDelegate

  func menuWillOpen(menu: NSMenu) {
    
  }
}