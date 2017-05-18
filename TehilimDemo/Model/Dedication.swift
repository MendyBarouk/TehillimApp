//
//  Dedication.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 16/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class Dedication: NSObject {
    
    let firstDedi: String
    let secondDedi: String
    let thirdDedi: String
    
    enum key: String {
        case fromDate = "from_date"
        case toDate = "to_date"
        case text = "text"
        case longText = "long_text"
    }
    

    
    init(firstDedi: String, secondDedi: String, thirdDedi: String) {
        self.firstDedi = firstDedi
        self.secondDedi = secondDedi
        self.thirdDedi = thirdDedi
        super.init()
    }
    
    
}
