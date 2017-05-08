//
//  myDate.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 26/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import Foundation

class MyDate: NSObject {
    
    static let dateManager: MyDate = MyDate()
    
    var tahanoun: Bool = true
    var ellul: Bool = false
    let dateNow: String
    private var dateArray: [String] = []
    let day: Int
    let month: Int
    let weekday: Int
    
    override init() {
        //let dateStrDemo = "2017-08-23"
        //let dateFormaterDemo = DateFormatter()
        //dateFormaterDemo.dateFormat = "yyyy-MM-dd"
        let date = Date()//dateFormaterDemo.date(from: dateStrDemo)! //Date()
        let formatter = DateFormatter()//dateFormaterDemo//DateFormatter()
        formatter.dateStyle = .full
        formatter.calendar = Calendar(identifier: .hebrew)
        if Locale.current.languageCode == "he" || Locale.current.languageCode == "fr" {
            formatter.locale = Locale.current
        } else {
            formatter.locale = Locale(identifier: "en")
        }
        
        dateNow = formatter.string(from: date)
        day = formatter.calendar.component(.day, from: date)
        month = formatter.calendar.component(.month, from: date)
        weekday = formatter.calendar.component(.weekday, from: date)
        
        let dateArrayTemp = dateNow.replacingOccurrences(of: ",", with: "").components(separatedBy: " ")
        if Locale.current.languageCode == "he" {
            dateArray.append("\(dateArrayTemp[0]) \(dateArrayTemp[1])")
            dateArray.append("\(dateArrayTemp[2]) \(dateArrayTemp[3])")
        } else {
            dateArray.append("\(dateArrayTemp[0])")
            dateArray.append("\(dateArrayTemp[1]) \(dateArrayTemp[2])")
        }
        
        super.init()
        
        if self.month == 13 || (self.month == 1 && self.day < 10) {
            ellul = true
        } else {
            ellul = false
        }
        
        if self.month == 13 || (month == 1 && day < 10) {
            ellul = true
        }
        
        let roshChodesh = self.day == 30 || self.day == 1
        let tichreyMonth = month == 1 && day > 10
        let chanuka = month == 3 && day >= 25 || month == 4 && day <= 2
        let touBishvat = month == 5 && day == 15
        let purim = (month == 6 || month == 7) && (day == 14 || day == 15)
        let nissan = month == 8
        let pessahSheni = month == 9 && day == 14
        let lagBaomer = month == 9 && day == 18
        let shavuhot = month == 10 && day == 7
        let tishaBeav = month == 12 && day == 9
        let tuBeav = month == 12 && day == 15
        
        if  roshChodesh || tichreyMonth || chanuka || touBishvat || purim || nissan || pessahSheni || lagBaomer || shavuhot || tishaBeav || tuBeav {
            tahanoun = false
        }
    }
 
    func dayAndMonth() -> String {
        return dateArray[1]
    }
    
    func dayOfWeek() -> String {
        return dateArray[0].capitalized
    }
    
    func twoDayOfRoshChodesh() -> Bool {
        let calendar = Calendar(identifier: .hebrew)
        guard let date = calendar.date(byAdding: .day, value: 1, to: Date()) else {
            return false
        }
        if calendar.component(.day, from: date) == 30 {
            return true
        }
        return false
    }
    
    
}
