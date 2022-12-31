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
        var encName:String = ""
        var writtenBytes:Int = 0
        for i in 0 ... name.count - 1 {
            var mickey = name.utf16
            encName += String(70 - (26 - Int(Float(mickey[mickey.index(mickey.startIndex, offsetBy: i)])) + 65))
            print(encName)
            writtenBytes += 1
        }
        encName += String(endBytes[Int.random(in: 1 ... endBytes.count)]) //Works thus far
        writtenBytes += 1
        log += "Name encoded as: \(encName)\n"
        var fullNameStr = encName
        while writtenBytes != 15 {
            fullNameStr += String(10 + Int.random(in: 0 ... 89))
            writtenBytes += 1
        }
        print("TEST... \(fullNameStr) with written \(writtenBytes)")
        var checksumFullName = 0
        for i in 0 ... fullNameStr.count - 1 {
            var mickey = fullNameStr.utf16
            checksumFullName += Int(mickey[mickey.index(mickey.startIndex, offsetBy: i)]) - 48
        }
        var checksumName = 0
        for i in 0 ... encName.count - 1 {
            var mickey = encName.utf16
            checksumName += Int(mickey[mickey.index(mickey.startIndex, offsetBy: i)]) - 48
        }
        checksumName = checksumName % 100
        var templog = String(checksumFullName)
        log += "Checksum of full name: \(templog)\n"
        var checkSumPart1 = checksumFullName + Int.random(in: 0 ... (999 - checksumFullName))
        var checkSumPart2 = checkSumPart1 - checksumFullName
        var retStr: String = ""
        retStr += String(checkSumPart1)
        retStr = String(retStr.reversed())
        retStr += fullNameStr
        retStr += String(checkSumPart2)
        retStr += String(checksumName)
        return ret
        retStr = retStr.insert("-", at: retStr.index(retStr.startIndex, offsetBy: 3))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
