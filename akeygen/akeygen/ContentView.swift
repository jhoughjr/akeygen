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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .onTapGesture {
//                    OpenWindow(id: "logs", value: log) TODO: IMPLEMENT THIS SOMEHOW
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
    
    func generateKeyFromName() {
        /*
         var ret = "";
            name = name.toUpperCase();
            var nameRecalc = name;
            
            if (name.length >= 15){
                console.log("Name too long");
                return "#";
            }
            for (var i = 0; i < name.length; i++){
                var a = name.charAt(i);
                if ((a < 'A' || a > 'Z') && a != "_" && (a < '0' || a > '9')){
                    console.log("Invalid character, use only A to Z uppercase");
                    return "#";
                }
            }
            
            var encName = "";
            var writtenBytes = 0;
            for (var i = 0; i < name.length; i++){
                encName += (70 - (26 - (name.charCodeAt(i) - 'A'.charCodeAt(0)))).toString();
                writtenBytes++;
            }
            encName += (EndBytes[Math.floor(Math.random() * EndBytes.length)]).toString();
            writtenBytes++;
            console.log("Encoded name as: " + encName);
            
            var fullNameStr = encName;
            
            while (writtenBytes != 15){
                fullNameStr += (10+Math.floor(Math.random() * 89)).toString();
                writtenBytes++;
            }
            
            var checksumFullName = 0;
            for (var i = 0; i < fullNameStr.length; i++){
                checksumFullName += (fullNameStr.charCodeAt(i) - '0'.charCodeAt(0));
            }
            var checksumName = 0;
            for (var i = 0; i < encName.length; i++){
                checksumName += (encName.charCodeAt(i) - '0'.charCodeAt(0));
            }
            checksumName %= 100;
            
            console.log("checksum of full name: " + checksumFullName);
            var checkSumPart1 = checksumFullName + Math.floor(Math.random() * (999-checksumFullName));
            var checkSumPart2 = checkSumPart1 - checksumFullName;
            
            var retStr = "";
            retStr += ('000'+checkSumPart1).slice(-3);
            retStr = retStr.split("").reverse().join("");
            retStr += fullNameStr;
            retStr += ('000'+checkSumPart2).slice(-3);
            retStr += ('00'+checksumName).slice(-2);

            retStr = retStr.slice(0, 6) + "-" + retStr.slice(6);
            retStr = retStr.slice(0, 15) + "-" + retStr.slice(15);
            retStr = retStr.slice(0, 23) + "-" + retStr.slice(23);
            retStr = retStr.slice(0, 31) + "-" + retStr.slice(31);
            retStr = retStr.slice(0, 36) + "-" + retStr.slice(36);

            return retStr;
         */
        log += "generating key for \"\(fullName)\" with end bytes \(endBytes.map({" \($0) "}))\n"

        if validate(fullName) {
            key = String(data:encode(fullName),
                         encoding:.utf8) ?? ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
