//
//  LocalizableUtils.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 27/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import Foundation
import UIKit

extension String{
    var localizedString : String{
        get{
            return NSLocalizedString(self, comment: self)
        }
    }
    
    var isHebrew: Bool {
        let letters = " אבגדהוזחטיכךלמםנןסעפףצץקרשת"
        
        for c in self.characters.map({ String($0) }) {
            if !letters.contains(c) {
                return false
            }
        }
        
        return true
    }
    
    var isNumber: Bool {
        let numbers = ",1234567890"
        
        if self.characters.first == "," {
            return false
        }
        for c in self.characters.map({ String($0) }) {
            if !numbers.contains(c) {
                return false
            }
        }
        
        return true
    }
}
