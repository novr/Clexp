//
//  UserDefaults.swift
//  
//
//  Created by 古宮 伸久 on 2022/07/14.
//

import Foundation

extension UserDefaults {

    var from: String? {
        get { string(forKey: "from") }
        set { set(newValue?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "from") }
    }

    var with: String? {
        get { string(forKey: "with") }
        set { set(newValue?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "with") }
    }
}
