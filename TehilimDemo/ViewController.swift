//
//  ViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 04/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tehilim: Tehilim!
    
    @IBOutlet weak var dayOfMonth: MyButton!
    @IBOutlet weak var dayOfWeek: MyButton!
    @IBOutlet weak var ellulButton: MyButton!
    @IBOutlet weak var tahanouneButton: MyButton!
    
    @IBAction func choiceOfButtonAction(_ sender: UIButton) {
        var chapters: [String]
        var title: String
        switch sender.tag {
        case 2: chapters = tehilim.getNamesTehilimBy(dayOfMonth: MyDate.dateManager.day); title = "yom \(MyDate.dateManager.day)"
        case 4: chapters = tehilim.getNamesTehilimBy(weekday: MyDate.dateManager.weekday); title = "yom \(MyDate.dateManager.weekday)"
        case 5: chapters = tehilim.getAllNamesOfTehilim(); title = "All Tehilim"
        case 6: chapters = tehilim.perek20(); title = "Perek 20"
        case 7: chapters = tehilim.getNamesTehilimOfEllulMonthBy(dayOfMonth: MyDate.dateManager.day, month: MyDate.dateManager.month); title = "3 tehilim of ellul"
        default:
            return
        }
        let nextVC = TehilimViewController.viewController(with: chapters, andTitle: title)
        self.navigationController?.pushViewController(nextVC, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tehilim = Tehilim.tehilimManager
        navigationItem.title = "tehilim_title".localizedString
        
        // Do any additional setup after loading the view, typically from a nib.
        dayOfMonth.setTitle("day_of_month".localizedString + MyDate.dateManager.dayAndMonth(), for: .normal)
        dayOfWeek.setTitle("day_of_week".localizedString + MyDate.dateManager.dayOfWeek(), for: .normal)
        if !MyDate.dateManager.ellul {
            ellulButton.isHidden = true
        }
        if MyDate.dateManager.tahanoun {
            tahanouneButton.isHidden = true
        }
        
    }
    


}

