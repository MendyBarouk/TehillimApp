//
//  MyDateLabel.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 02/06/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class MyDateLabel: UILabel {
    
    //from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //from code
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    private func setup(){
        self.text = MyDate.dateManager.dateNow.capitalized
    }

}
