//
//  MyLabel.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 23/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class MyLabel: UILabel {

    @IBInspectable var localizedKey : String? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let localizedKey = localizedKey{
            self.text = localizedKey.localizedString
        }
    }

}
