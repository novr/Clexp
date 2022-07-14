//
//  Environment.swift
//  
//
//  Created by 古宮 伸久 on 2022/07/13.
//

import AppKit
import Foundation

struct Environment {
    static var current = Environment()

    var isActive: Bool { NSApp.isActive }

    let pasteBoardService: PasteboardService
    let defaults: UserDefaults

    init(defaults: UserDefaults = UserDefaults.standard,
         pasteBoardService: PasteboardService = PasteboardService()) {
        self.defaults = defaults
        self.pasteBoardService = pasteBoardService
    }
}
