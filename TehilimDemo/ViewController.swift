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
        case 2: chapters = tehilim.getNamesTehilimBy(dayOfMonth: MyDate.dateManager.day); title = MyDate.dateManager.dayAndMonth()
        case 4: chapters = tehilim.getNamesTehilimBy(weekday: MyDate.dateManager.weekday); title = MyDate.dateManager.dayOfWeek()
        case 5: chapters = tehilim.getAllNamesOfTehilim(); title = "All Tehilim"
        case 6: chapters = tehilim.perek20(); title = "Perek 20"
        case 7: chapters = tehilim.getNamesTehilimOfEllulMonthBy(dayOfMonth: MyDate.dateManager.day, month: MyDate.dateManager.month); title = "3 tehilim of ellul"
        default:
            return
        }
        let nextVC = TehilimViewController.viewController(with: chapters, andTitle: title)
        self.navigationController?.pushViewController(nextVC, animated: true)

    }
    
    @IBAction func yehiRatzonAction(_ sender: UIButton) {
        let sheet = UIAlertController(title: "Yehi Ratzon", message: "Please choose the yehi ratzon", preferredStyle: .actionSheet)
        
        func handler(_ action: UIAlertAction){
            guard let title = action.title else {
                return
            }
            switch title {
            case "yehi_ratzon_befor".localizedString:
                let nextVC = TehilimViewController.viewController(with: tehilim.getYehiRatzon(befor: true), andTitle: "Yehi Ratzon")
                self.navigationController?.pushViewController(nextVC, animated: true)
            case "yehi_ratzon_after".localizedString:
                let nextVC = TehilimViewController.viewController(with: tehilim.getYehiRatzon(befor: false), andTitle: "Yehi Ratzon")
                self.navigationController?.pushViewController(nextVC, animated: true)
            default:
                return
            }
        }
        sheet.addAction(UIAlertAction(title: "yehi_ratzon_befor".localizedString, style: .default, handler: handler))
        sheet.addAction(UIAlertAction(title: "yehi_ratzon_after".localizedString, style: .default, handler: handler))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(sheet, animated: true, completion: nil)
        
        
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

