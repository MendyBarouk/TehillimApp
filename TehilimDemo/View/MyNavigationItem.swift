//
//  MyNavigationItem.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 11/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class MyNavigationItem: UINavigationItem {
    //from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        self.title = "tehilim_title".localizedString
    }
}
