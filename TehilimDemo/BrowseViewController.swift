//
//  BrowseViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 30/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var tehilim: Tehilim!
    var pickerView: UIPickerView!
    var pickerViewData: Array<String>!
    var pickerViewRows: Int!
    var pickerViewMiddle: Int!
    
    
    @IBAction func chooseChapter(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            choose(array: Array(1...150).map {
                String($0)
            }, white: 1, title: "choose_chapter".localizedString) {
                let selected = Int(self.valueForRow(row: self.pickerView.selectedRow(inComponent: 0)))!
                let nextVC = TehilimViewController.viewController(with: self.tehilim.getNamesTehilimBy(perek: selected), andTitle: "chapter".localizedString + " \(selected)")
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        case 2:
            choose(array: Array(1...5).map {
                String($0)
            }, white: 2, title: "choose_book".localizedString) {
                let selected = Int(self.valueForRow(row: self.pickerView.selectedRow(inComponent: 0)))!
                let nextVC = TehilimViewController.viewController(with: self.tehilim.getNamesTehilimBy(sefer: selected), andTitle: "book".localizedString + " \(selected)")
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        case 3:
            let array = ["sunday".localizedString, "monday".localizedString, "tuesday".localizedString, "wednesday".localizedString, "thursday".localizedString,"friday".localizedString,"saturday".localizedString]
            choose(array: array, white: 3, title: "choose_weekday".localizedString) {
                let selected = array.index(of: self.valueForRow(row: self.pickerView.selectedRow(inComponent: 0)))! + 1
                
                let nextVC = TehilimViewController.viewController(with: self.tehilim.getNamesTehilimBy(weekday: selected), andTitle: array[selected - 1])
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        case 4:
            choose(array: Array(1...30).map {
                String($0)
            }, white: 3, title: "choose_monthday".localizedString) {
                let selected = Int(self.valueForRow(row: self.pickerView.selectedRow(inComponent: 0)))!
                let nextVC = TehilimViewController.viewController(with: self.tehilim.getNamesTehilimBy(dayOfMonth: selected), andTitle: "day \(selected)")
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        default:
            return
        }
        
    }
    @IBAction func tikunHaklaliAction(_ sender: Any) {
        let tikunHaklali = tehilim.tikunHaklali()
        let nextVC = TehilimViewController.viewController(with: tikunHaklali, andTitle: "Tikun Haklali")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func randomPerekAction(_ sender: Any) {
        let perek = tehilim.randomTehilim()
        let nextVC = TehilimViewController.viewController(with: perek.values.first!, andTitle: "random_chapter".localizedString + " \(perek.keys.first!)")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func segulotAction(_ sender: UIButton) {
        let sheet = UIAlertController(title: "Segulot", message: nil, preferredStyle: .actionSheet)
        
    }
    
    func choose(array: Array<String>, white tag: Int, title: String, doneAction: @escaping ()->Void) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 200)
        
        pickerViewData = array
        pickerViewRows = pickerViewData.count*2
        pickerViewMiddle = ((pickerViewRows / pickerViewData.count) / 2) * pickerViewData.count
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 190))
        pickerView.tag = 1
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.layer.cornerRadius = 25
        pickerView.backgroundColor = UIColor.init(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5)
        pickerView.selectRow(rowForValue(value: 0), inComponent: 0, animated: true)
        
        vc.view.addSubview(pickerView)
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.setValue(vc, forKey: "contentViewController")
        
        
        let doneAction = UIAlertAction(title: "Done", style: .default, handler: { action in
            doneAction()
        })
        alert.addAction(doneAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        self.present(alert, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tehilim = Tehilim.tehilimManager
        navigationItem.title = "tehilim_title".localizedString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIPickerViewDataSource
    
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewRows
    }
    
    // MARK: - UIPickerViewDelegate
//    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "\(valueForRow(row: row))"
//    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = "\(valueForRow(row: row))"
        let str: NSAttributedString = NSAttributedString.init(string: title, attributes: [NSForegroundColorAttributeName:UIColor.white])
        return str
    }
    
    func valueForRow(row: Int) -> String {
        return pickerViewData[row%pickerViewData.count]
    }
    
    func rowForValue(value: Int) -> Int {
        return pickerViewMiddle + value
        
    }

}











