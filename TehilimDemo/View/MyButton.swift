//
//  MyButton.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 26/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class MyButton: UIButton {

    @IBInspectable var localizedKey : String? = nil

    
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
        self.layer.shadowColor = UIColor.init(red: 40/255, green: 40/255, blue: 40/255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
        self.titleLabel?.font = UIFont(descriptor: .init(), size: 20)
        
        self.addTarget(self, action: #selector(myButtonSelected), for: UIControlEvents.touchDown)
        self.addTarget(self, action: #selector(myButtonNoSelected), for: UIControlEvents.touchUpInside)
        self.addTarget(self, action: #selector(myButtonNoSelected), for: UIControlEvents.touchDragExit)
        
        if let localizedKey = localizedKey{
            self.setTitle(localizedKey.localizedString, for: .normal)
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let localizedKey = localizedKey{
            self.setTitle(localizedKey.localizedString, for: .normal)
        }
    }
    
    func myButtonSelected() {
        self.layer.position.y += 1
        self.layer.shadowColor = UIColor.init(red: 104/255, green: 104/255, blue: 104/255, alpha: 1).cgColor
    }
    
    func myButtonNoSelected() {
        self.layer.position.y -= 1
        self.layer.shadowColor = UIColor.init(red: 40/255, green: 40/255, blue: 40/255, alpha: 1).cgColor
    }

}











