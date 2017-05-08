//
//  DateViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 27/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = MyDate.dateManager.dateNow.capitalized

    }


}
