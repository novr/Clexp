//
//  AppDelegate.swift
//  
//
//  Created by 古宮 伸久 on 2022/07/12.
//

import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var service: PasteboardService?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        NSApp.windows.forEach{ $0.close() }

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let button = statusItem.button!
        button.image = NSImage(systemSymbolName: "plus.rectangle", accessibilityDescription: nil)

        let menu = NSMenu()
        menu.addItem(
            withTitle: NSLocalizedString("Preference", comment: "Show preferences window"),
            action: #selector(openPreferencesWindow),
            keyEquivalent: ""
        )
        menu.addItem(.separator())
        menu.addItem(
            withTitle: NSLocalizedString("Quit", comment: "Quit app"),
            action: #selector(terminate),
            keyEquivalent: ""
        )
        statusItem.menu = menu
        Environment.current.pasteBoardService.startMonitoring()
    }

    @objc func terminate() {
        NSApp.terminate(self)
    }

    @objc func openPreferencesWindow() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        NSApp.activate(ignoringOtherApps: true)
    }

}
