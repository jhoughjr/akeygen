//
//  akeygenApp.swift
//  akeygen
//
//  Created by Jimmy Hough Jr on 12/28/22.
//

import SwiftUI
import AppKit
@main
struct akeygenApp: App {
    @State var log: String = ""
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        Window("Log", id: "logs") {
//            @Binding var log:String
//            LogUI(log: $log) TODO: IMPLEMENT THIS SOMEHOW
//        }
        Window("OldVer", id: "legacy") {
            LegacyVerView()
                .onAppear {
                    DispatchQueue.main.async {
                        
                    }
                    
                }
        }
    }
}
