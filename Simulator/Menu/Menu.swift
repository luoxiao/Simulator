import Cocoa

struct Menu {

  static func load(devices: [Device]) -> [NSMenuItem] {
    var items: [NSMenuItem] = []

    var osInfo: String = ""

    devices.forEach {
      if $0.osInfo != osInfo {
        if !items.isEmpty {
          items.append(NSMenuItem.separatorItem())
        }
        items.append(Menu.header(osInfo))
        osInfo = $0.osInfo
      }

      items.append(load($0))
    }

    return items
  }

  static func load(device: Device) -> NSMenuItem {
    let item = NSMenuItem()
    item.title = device.name
    item.enabled = device.isAvailable
    item.state = device.isOpen ? 1 : 0
    item.onStateImage = NSImage(named: "on")
    item.offStateImage = NSImage(named: "off")

    let menu = NSMenu()
    menu.autoenablesItems = false

    let applications = load(device.applications)
    if !applications.isEmpty {
      menu.addItem(Menu.header("Applications"))
      applications.forEach {
        menu.addItem($0)
      }
    }

    let appGroups = load(device.appGroups)
    if !appGroups.isEmpty {
      menu.addItem(Menu.header("App Groups"))
      appGroups.forEach {
        menu.addItem($0)
      }
    }

    let media = load(device.media)
    if !media.isEmpty {
      menu.addItem(Menu.header("Media"))
      media.forEach {
        menu.addItem($0)
      }
    }

    item.submenu = menu
    return item
  }

  private static func load(applications: [Application]) -> [NSMenuItem] {
    return applications.map {
      let item = NSMenuItem()
      item.title = $0.udid
      item.enabled = true

      return item
    }
  }

  private static func load(appGroups: [AppGroup]) -> [NSMenuItem] {
    return appGroups.map {
      let item = NSMenuItem()
      item.title = $0.bundleIdentifier
      item.enabled = true

      return item
    }
  }

  private static func load(media: [Media]) -> [NSMenuItem] {
    return media.map {
      let item = NSMenuItem()
      item.title = $0.name
      item.enabled = true

      return item
    }
  }

  // MARK: - Helper

  private static func header(title: String) -> NSMenuItem {
    let item = NSMenuItem()
    item.title = title
    item.enabled = false

    return item
  }
}