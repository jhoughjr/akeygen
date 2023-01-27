//
//  SettingsView.swift
//  akeygen
//
//  Created by Alex Vysokai on 1/27/23.
//

import SwiftUI
class Preferences:ObservableObject {
  static let shared = Preferences()
    @Published var ver: Int = 2
}
struct SettingsView: View {
    @ObservedObject var sel1 = Preferences.shared
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Picker(selection: $sel1.ver, label: Text("Version Select")) {
            Text("Original").tag(1)
            Text("Modified").tag(2)
        }
        .pickerStyle(.menu)
    }
}


