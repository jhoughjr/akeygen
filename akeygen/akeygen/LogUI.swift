//
//  LogUI.swift
//  akeygen
//
//  Created by Alex Vysokai on 29/12/2022.
//

import SwiftUI
//TODO: TRY TO ISOLATE TO A SEPARATE WINDOW
struct LogUI: View {
    @Binding var log: String
    var body: some View {
        VStack {
            VStack {
                Text("Log")
                    .font(.custom("Minecraft", size: 20))
                HStack {
                    Button {
                        log = ""
                    } label: {
                        Label(title: {Text("DestroyLog")}, icon: {Image(systemName: "eraser")})
                    }
                    Divider()
                        .frame(height: 10)
                    Button {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(log, forType: .string)
                    } label: {
                        Label(title: {Text("Copy Log")}, icon: {Image(systemName: "arrow.right.doc.on.clipboard")})
                    }
                }

            }
            TextEditor(text: $log)
        }
    }
}

