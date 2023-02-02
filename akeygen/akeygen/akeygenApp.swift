//
//  akeygenApp.swift
//  akeygen
//
//  Created by Jimmy Hough Jr and Alex Vysokai on 12/28/22.
//

import SwiftUI
struct VisualEffect: NSViewRepresentable {
  func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
  func updateNSView(_ nsView: NSView, context: Context) { }
}
class AppDelegate: NSObject, NSApplicationDelegate {
    private var aboutBoxWindowController: NSWindowController?
    func showAbout() {
        if aboutBoxWindowController == nil {
                   let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable,/* .resizable,*/ .titled]
                   let window = NSWindow()
                   window.styleMask = styleMask
                   window.title = "About My App"
                   window.contentView = NSHostingView(rootView: AboutView())
                   aboutBoxWindowController = NSWindowController(window: window)
               }

               aboutBoxWindowController?.showWindow(aboutBoxWindowController?.window)
    }
}
@main

struct akeygenApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var log: String = ""
    var body: some Scene {
        WindowGroup {
            ContentView(log: $log)
        }
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button(action: {
                    appDelegate.showAbout()
                }, label: {
                    Text("About a key gen")
                })
            }
        }
        Window("Log", id: "logs") {
            LogUI(log: $log)
        }
        .keyboardShortcut("l", modifiers: .command)
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
