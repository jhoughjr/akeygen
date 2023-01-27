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
        Picker(selection: $sel1.ver, label: Text("Version Select")) {
            Text("JavaScript Ver").tag(1)
            Text("Swift Ver").tag(2)
        }
        .pickerStyle(.menu)
    }
}


