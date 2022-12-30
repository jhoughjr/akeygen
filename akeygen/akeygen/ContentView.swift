//
//  ContentView.swift
//  akeygen
//
//  Created by Jimmy Hough Jr on 12/28/22.
//

import SwiftUI

struct ContentView: View {
    @State var fullName = ""
    @State var key = ""
    @State var endBytes =  [39, 86, 26, 72, 13, 91, 23];
    @State var log: String = ""
    
    @Environment (\.openWindow) var OpenWindow
    
    var body: some View {
        VStack {
            Button {
                OpenWindow(id: "legacy")
            } label: {
                Text("Legacy")
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .onTapGesture {
//                    OpenWindow(id: "logs") TODO: IMPLEMENT THIS SOMEHOW
                }
            nameView
            endBytesView
            Button {
                generateKeyFromName()
            } label: {
                Text("Generate Key")
            }
            TextField("key", text: $key)
            
            LogUI(log: $log)
        }
        .padding()
    }
    
    var nameView: some View {
        VStack {
            Text("Full Name")
            TextField("", text: $fullName)
        }
    }
    
    var endBytesView: some View {
        VStack {
            Text("End Bytes")

            HStack {
                ForEach(endBytes, id:\.self) { byte in
                    Text("\(byte)").padding()
                        .font(.custom("Minecraft-Bold", size: 20))
                }
            }
        }
    }
    
    func validate(_ name:String) -> Bool {
        log += "validating \"\(name)\"\n"
        return validateLength(name) && validateCharset(name)
    }
    
    func validateLength(_ name:String) -> Bool {
        log += "validating length of\"\(name)\"\n"

        let isValid = name.count < 15 && !name.isEmpty
        if isValid {
            log += "length of\"\(name)\" is valid.\n"
            return true
        }else {
            log += "length of\"\(name)\" is NOT valid.\n"
            return false
        }
    }
    
    func validateCharset(_ name:String) -> Bool {
        log += "validating charset of\"\(name)\"\n"

        let r = 65...90
        
        let isValid = name.allSatisfy { c in
            r.contains(Int(c.asciiValue!))
        }
        if isValid {
            log += "charset of\"\(name)\" is valid. \n"

            return true
        }
        else {
            log += "charset of\"\(name)\" is NOT valid. \n"

            return false
        }
    }
    
    func encode(_ name:String) -> Data {
        log += "encoding \"\(name)\"\n"

        guard !name.isEmpty else {
            log += "Name can't be empty. returning empty data.\n"

            return Data()
        }
        
        if let d = fullName.data(using: .utf8) {
            log += "encoded \"\(d)\"\n"
            return d
        } else{
            log += "encoding \"\(name)\" failed. returning empty data\n"
            return Data()
        }
    }
    
    func generateKeyFromName() -> String {
        log += "generating key for \"\(fullName)\" with end bytes \(endBytes.map({" \($0) "}))\n"

        if validate(fullName) {
            key = String(data:encode(fullName),
                         encoding:.utf8) ?? ""
        }
        var ret:String = ""
        var name:String = fullName.uppercased()
        var nameRecalc:String = name
        if name.count >= 15 {
            print("Name too long")
            return "#"
        }
        var length:Int = name.count - 1
        let ValidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        if name.rangeOfCharacter(from: ValidCharSet.inverted) != nil {
            print("Invalid character, use only A to Z uppercase")
            return "#"
        }
        var encName:String
        var temp:DynamicProperty
        var writtenBytes:Int
        for i in 0 ... length {
        }
        return ret
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
