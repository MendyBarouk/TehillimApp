//
//  Dedication.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 16/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class Dedication: NSObject {
    
    let startDate : TimeInterval
    let endDate : TimeInterval
    let text : String
    let longText: String
    
    enum Key: String {
        case startDate = "start_date"
        case endDate = "end_date"
        case text = "text"
        case longText = "long_text"
    }

    init(_ dict : [String:Any]) {
        self.startDate = dict[Key.startDate.rawValue] as! TimeInterval
        self.endDate = dict[Key.endDate.rawValue] as! TimeInterval
        
        self.text = dict[Key.text.rawValue] as! String
        self.longText = dict[Key.longText.rawValue] as! String
    }
    
    func isValid() -> Bool{
        let now = Date().timeIntervalSince1970
        return now > startDate && now < endDate
        
    }

    
    
}
