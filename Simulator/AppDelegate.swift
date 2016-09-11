//
//  AppDelegate.swift
//  Simulator
//
//  Created by Khoa Pham on 11/09/16.
//  Copyright © 2016 Hyper. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet var statusMenu: NSMenu!
  let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

  func applicationDidFinishLaunching(aNotification: NSNotification) {
    statusItem.image = NSImage(named: "icon")
    statusItem.menu = statusMenu
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }
}

