import Cocoa

class MenuController: NSObject, NSMenuDelegate {

  @IBOutlet var statusMenu: NSMenu!
  let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

  override func awakeFromNib() {
    super.awakeFromNib()

    statusItem.image = NSImage(named: "icon")
    statusItem.menu = statusMenu
    statusItem.menu?.delegate = self

    let loader = Loader()
    loader.load()
  }

  // MARK: - NSMenuDelegate

  func menuWillOpen(menu: NSMenu) {
    let loader = Loader()
    loader.load()
  }
}