//
//  SettingsView.swift
//  
//
//  Created by 古宮 伸久 on 2022/07/12.
//

import SwiftUI
struct SettingsView: View {
    @AppStorage("from") var from = ""
    @AppStorage("with") var with = ""

    var body: some View {
        Form {
            TextField("from", text: $from)
            TextField("replace to", text: $with)
        }
        .navigationTitle("Clexp")
        .padding(5)
        .frame(width: 400, height: 100)
    }
}
