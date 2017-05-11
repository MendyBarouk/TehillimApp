//
//  Guematria.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 10/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class Guematria: NSObject {

    class func fromNumberToLetter(num: Int, completion: (_ success: Bool, _ result: String?) -> ()) {
        var s: Bool = false
        var r: String? = nil
        switch num {
        case 1: s = true; r = "א"
        case 2: s = true; r = "ב"
        case 3: s = true; r = "ג"
        case 4: s = true; r = "ד"
        case 5: s = true; r = "ה"
        case 6: s = true; r = "ו"
        case 7: s = true; r = "ז"
        case 8: s = true; r = "ח"
        case 9: s = true; r = "ט"
        case 10: s = true; r = "י"
        case 20: s = true; r = "כ"
        case 30: s = true; r = "ל"
        case 40: s = true; r = "מ"
        case 50: s = true; r = "נ"
        case 60: s = true; r = "ס"
        case 70: s = true; r = "ע"
        case 80: s = true; r = "פ"
        case 90: s = true; r = "צ"
        case 100: s = true; r = "ק"
        case 200: s = true; r = "ר"
        case 300: s = true; r = "ש"
        case 400: s = true; r = "ת"
        default:
            s = false
        }
        
        completion(s,r)
        
    }

    
    
}

