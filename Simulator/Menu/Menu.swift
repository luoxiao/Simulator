import Cocoa

struct Menu {

  static func load(devices: [Device]) -> [NSMenuItem] {
    var items: [NSMenuItem] = []

    var currentVersion: String = ""

    devices.forEach {
      if $0.version != currentVersion {
        currentVersion = $0.version
        items.append(NSMenuItem.separatorItem())
      }

      items.append(load($0))
    }

    return items
  }

  static func load(device: Device) -> NSMenuItem {
    let item = NSMenuItem()
    item.title = "\(device.name) (\(device.version)) "
    item.enabled = device.isAvailable
    item.state = device.isOpen ? 1 : 0
    item.onStateImage = NSImage(named: "on")
    item.offStateImage = NSImage(named: "off")

    let menu = NSMenu()
    menu.autoenablesItems = false

    load(device.applications).forEach {
      menu.addItem($0)
    }

    load(device.appGroups).forEach {
      menu.addItem($0)
    }

    load(device.media).forEach {
      menu.addItem($0)
    }

    item.submenu = menu
    return item
  }

  static func load(applications: [Application]) -> [NSMenuItem] {
    return applications.map {
      let item = NSMenuItem()
      item.title = $0.udid
      item.enabled = true

      return item
    }
  }

  static func load(appGroups: [AppGroup]) -> [NSMenuItem] {
    return appGroups.map {
      let item = NSMenuItem()
      item.title = $0.bundleIdentifier
      item.enabled = true

      return item
    }
  }

  static func load(media: [Media]) -> [NSMenuItem] {
    return media.map {
      let item = NSMenuItem()
      item.title = $0.name
      item.enabled = true

      return item
    }
  }
}