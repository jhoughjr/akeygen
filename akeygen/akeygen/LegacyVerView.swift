//
//  LegacyVerUIView.swift
//  akeygen
//
//  Created by Alex Vysokai on 29/12/2022.
//

import SwiftUI

struct LegacyVerView: View {
    
    var body: some View {
        
        ZStack {
            HostingWindowFinder { window in
                        window?.standardWindowButton(.zoomButton)?.isEnabled = false //this disables the green zoom button
                    }
            Text("For users that use the verion 05-04 you need a key that\n is actually hard coded and you were\n supposed to ask dev0\n for it but since the server is non-functional\n here is the code:")
                .font(.custom("Minecraft", size: 15))
        }
        GroupBox(label:
                    Label {
            Text("Keys:")
                .foregroundColor(.primary)
        } icon: {
            Image(systemName: "key.radiowaves.forward")
        }
        ) {
            VStack {
                Text("Unlock Key")
                    .font(.system(size: 25,weight: .thin, design: .monospaced))
                Text("47984-25158-78941")
                    .font(.system(size: 15,weight: .thin, design: .monospaced))
                Button(action: {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString("47984-25158-78941", forType: .string)
                }) {
                    Text("Copy to clipboard")
                    Image(systemName: "arrow.right.doc.on.clipboard")
                }
                Text("Cheat Key")
                    .font(.system(size: 25,weight: .thin, design: .monospaced))
                Text("2259403-191299")
                    .font(.system(size: 15,weight: .thin, design: .monospaced))
                Button(action: {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString("2259403-191299", forType: .string)
                }) {
                    Text("Copy to clipboard")
                    Image(systemName: "arrow.right.doc.on.clipboard")
                }
            }
            
        }
        .padding()
    }
}

struct HostingWindowFinder: NSViewRepresentable {
    var callback: (NSWindow?) -> ()

    func makeNSView(context: Self.Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
        return view
    }
    func updateNSView(_ nsView: NSView, context: Context) {}
}

struct LegacyVerUIView_Previews: PreviewProvider {
    static var previews: some View {
        LegacyVerView()
    }
}
