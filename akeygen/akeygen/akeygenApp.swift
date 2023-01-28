//
//  akeygenApp.swift
//  akeygen
//
//  Created by Jimmy Hough Jr and Alex Vysokai on 12/28/22.
//

import SwiftUI
import AppKit
@main
struct akeygenApp: App {
    @State var log: String = ""
    var body: some Scene {
        WindowGroup {
            ContentView(log: $log)
        }
        Window("Log", id: "logs") {
            LogUI(log: $log)
        }
        .defaultPosition(.bottom)
        Window("OldVer", id: "legacy") {
            LegacyVerView()
        }
        Settings {
            SettingsView()
                .frame(width: 250, height: 200)
        }
    }
}
