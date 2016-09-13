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

    menu.addItem(NSMenuItem.separatorItem())
    menu.addItem(makeQuitItem())

    return menu
  }

  func makeQuitItem() -> NSMenuItem {
    let item = NSMenuItem()
    item.title = "Quit"
    item.enabled = true
    item.target = self
    item.action = #selector(quit(_:))

    return item
  }

  // MARK: - Action

  func quit(item: NSMenuItem) {
    NSApplication.sharedApplication().terminate(self)
  }

  // MARK: - NSMenuDelegate

  func menuWillOpen(menu: NSMenu) {
    
  }
}