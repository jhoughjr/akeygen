//
//  AboutView.swift
//  akeygen
//
//  Created by Alex Vysokai on 02/02/2023.
//

import SwiftUI

struct AboutView: View {
    @State private var CrtY: Int = 0
    var body: some View {
        VStack {
            Image("AppNFO")
            Text("Akeygen")
                .font(.custom("Minecraft-bold",size: 30))
            Divider()
            Text("Made by Gladosator and Jimmy")
                .font(.custom("Minecraft", size: 15))
            Text("© Alex Vysokai \(String(format:"%04d",CrtY)), All rights reserved")
        }
        .onAppear() {
            let calendar = Calendar.current
            CrtY = calendar.component(.year, from: Date())


        }
        .frame(minWidth: 400, minHeight: 400)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
