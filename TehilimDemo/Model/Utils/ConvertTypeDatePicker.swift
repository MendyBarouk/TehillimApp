//
//  ConvertTypeDatePicker.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 15/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import Foundation

enum ConvertTypeDatePicker: Int {
    
    case Hebrew = 0
    case Gregorian
    
    
    func calendar() -> Calendar {
        switch self {
        case .Gregorian:
            return Calendar(identifier: .gregorian)
        case .Hebrew:
            return Calendar(identifier: .hebrew)
        }
    }
    
}
