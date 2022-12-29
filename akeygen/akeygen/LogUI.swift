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
                    .font(.caption)
                Button {
                    log = ""
                } label: {
                    Label(title: {Text("DestroyLog")}, icon: {Image(systemName: "eraser")})
                }

            }
            TextEditor(text: $log)
        }
    }
}

