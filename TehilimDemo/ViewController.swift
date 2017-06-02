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
    
    @IBOutlet weak var yehiRazonButton: MyButton!
    @IBOutlet weak var dayOfMonth: MyButton!
    @IBOutlet weak var myChapterButton: MyButton!
    
    @IBOutlet weak var editChapterButton: UIButton!
    @IBOutlet weak var dayOfWeek: MyButton!
    @IBOutlet weak var allTehilimButton: MyButton!
    @IBOutlet weak var ellulButton: MyButton!
    
    @IBOutlet weak var tahanouneButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var ellulButtonContraint: NSLayoutConstraint!
    @IBOutlet weak var ellulButtonTopConstraint: NSLayoutConstraint!
    //@IBOutlet weak var ellulButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var tahanouneButton: MyButton!

    
//    @IBAction func swipeLeftAction(_ sender: UISwipeGestureRecognizer) {
//        guard let tabBarController = self.tabBarController else {
//            return
//        }
//        
//        let selectedIndex = tabBarController.selectedIndex
//        let selectedController = tabBarController.selectedViewController
//        let viewControllers = tabBarController.viewControllers!
//        
//        let nextIndex = selectedIndex + 1
//        let fromView = selectedController?.view
//        let toView = viewControllers[nextIndex]
//
//        
//        UIView.animate(withDuration: 0.25, animations: {
//            self.view.alpha = 0.2
//            
//        }) { (_) in
//            self.view.alpha = 1
//            UIView.transition(from: fromView!,
//                              to: toView.view,
//                              duration: 0.25,
//                              options: UIViewAnimationOptions.transitionCrossDissolve,
//                              completion: {(finished : Bool) -> () in
//                                if finished {
//                                    tabBarController.selectedIndex = nextIndex
//                                }
//            })
//        }
//        
//    }
//    
    
    @IBAction func choiceOfButtonAction(_ sender: UIButton) {
        var chapters: [String]
        var title: String
        switch sender.tag {
        case 2: chapters = tehilim.getNamesTehilimBy(dayOfMonth: MyDate.dateManager.day); title = MyDate.dateManager.dayAndMonth()
        case 4: chapters = tehilim.getNamesTehilimBy(weekday: MyDate.dateManager.weekday); title = MyDate.dateManager.dayOfWeek()
        case 5: chapters = tehilim.getAllNamesOfTehilim(); title = "all_psalm".localizedString
        case 6: chapters = tehilim.perek20(); title = "no_tachanun".localizedString
        case 7: chapters = tehilim.getNamesTehilimOfEllulMonthBy(dayOfMonth: MyDate.dateManager.day, month: MyDate.dateManager.month); title = "ellul_chapters".localizedString
        default:
            return
        }
        let nextVC = TehilimViewController.viewController(with: chapters, andTitle: title)
        self.navigationController?.pushViewController(nextVC, animated: true)

    }
    
    @IBAction func yehiRatzonAction(_ sender: UIButton) {
        let sheet = UIAlertController(title: "yehi_ratzon".localizedString, message: "yehi_ratzon_choose".localizedString, preferredStyle: .actionSheet)
        
        func handler(_ action: UIAlertAction){
            guard let title = action.title else {
                return
            }
            switch title {
            case "yehi_ratzon_befor".localizedString:
                let nextVC = TehilimViewController.viewController(with: tehilim.getYehiRatzon(befor: true), andTitle: "yehi_ratzon".localizedString)
                self.navigationController?.pushViewController(nextVC, animated: true)
            case "yehi_ratzon_after".localizedString:
                let nextVC = TehilimViewController.viewController(with: tehilim.getYehiRatzon(befor: false), andTitle: "yehi_ratzon".localizedString)
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
    
    
    @IBAction func myChaptersAction(_ sender: UIButton) {
        if TehilimCore.fetchedAllObject().isEmpty {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MyChaptersTableViewController")
            self.navigationController?.pushViewController(nextVC!, animated: true)
        } else {
            let myChapters = tehilim.getMyChaptersBy(tehilimCore: TehilimCore.fetchedAllObject())
            let nextVC = TehilimViewController.viewController(with: myChapters, andTitle: "my_chapters".localizedString)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
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
            //ellulButtonConstraint.constant = 0
            ellulButtonContraint.constant = 0
        }
        else {
            ellulButton.isHidden = false
            ellulButtonContraint.constant = 44
        }
        
        if MyDate.dateManager.tahanoun && MyDate.dateManager.ellul {
            ellulButtonTopConstraint.constant = 0
        } else {
            ellulButtonTopConstraint.constant = 16
        }
        
        if MyDate.dateManager.tahanoun {
            tahanouneButton.isHidden = true
            tahanouneButtonConstraint.constant = 0
        } else {
            tahanouneButton.isHidden = false
            tahanouneButtonConstraint.constant = 44
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}














