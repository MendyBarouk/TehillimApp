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
}
