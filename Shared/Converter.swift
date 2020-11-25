//
//  Converter.swift
//  IntentKit
//
//  Created by Annika Pfosch on 25.11.20.
//

import Foundation

class Converter {
    
    func convertDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.locale = Locale.current
        let dateObj = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: dateObj!)
    }
    
    func convertLocation2Room(room: String) -> String {
        var result : String = ""
        if let index = room.firstIndex(of: ",") {
            let firstPart = room.prefix(upTo: index)
            print(firstPart) // print hello
            result = firstPart.description
        }
        return result
    }
}
