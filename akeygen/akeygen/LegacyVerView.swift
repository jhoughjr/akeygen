//
//  LegacyVerUIView.swift
//  akeygen
//
//  Created by Alex Vysokai on 29/12/2022.
//

import SwiftUI

struct LegacyVerView: View {
    
    var body: some View {
        HostingWindowFinder { window in
                    window?.standardWindowButton(.zoomButton)?.isEnabled = false //this disables the green zoom button
                }
    Text("For users that use the verion 05-04 you need a key that is actually hard coded and you were\n supposed to ask dev0 for it but since the server is non-functional\n here is the code:")
            .font(.callout)
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
                Button(action: {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString("HELLO", forType: .string)
                }) {
                    Text("Copy to clipboard")
                    Image(systemName: "arrow.right.doc.on.clipboard")
                }
            }
            
        }
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
