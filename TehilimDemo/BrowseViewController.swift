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
    var pickerViewData: Array<Int>!
    var pickerViewRows: Int!
    var pickerViewMiddle: Int!
    
    
    @IBAction func chooseChapter(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            choose(array: Array(1...150), white: 1, title: "Select Chapter") {
                let selected = self.valueForRow(row: self.pickerView.selectedRow(inComponent: 0))
                let nextVC = TehilimViewController.viewController(with: self.tehilim.getNamesTehilimBy(perek: selected), andTitle: "chapter \(selected)")
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        case 2:
            choose(array: Array(1...5), white: 2, title: "Select a Book") {
                let selected = self.valueForRow(row: self.pickerView.selectedRow(inComponent: 0))
                let nextVC = TehilimViewController.viewController(with: self.tehilim.getNamesTehilimBy(sefer: selected), andTitle: "Book \(selected)")
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        case 3:
            choose(array: Array(1...7), white: 3, title: "Select day") {
                let selected = self.valueForRow(row: self.pickerView.selectedRow(inComponent: 0))
                let nextVC = TehilimViewController.viewController(with: self.tehilim.getNamesTehilimBy(weekday: selected), andTitle: "day \(selected)")
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        case 4:
            choose(array: Array(1...30), white: 3, title: "Select day") {
                let selected = self.valueForRow(row: self.pickerView.selectedRow(inComponent: 0))
                let nextVC = TehilimViewController.viewController(with: self.tehilim.getNamesTehilimBy(dayOfMonth: selected), andTitle: "day \(selected)")
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        default:
            return
        }
        
    }
    
    func choose(array: Array<Int>, white tag: Int, title: String, doneAction: @escaping ()->Void) {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    func valueForRow(row: Int) -> Int {
        return pickerViewData[row%pickerViewData.count]
    }
    
    func rowForValue(value: Int) -> Int {
        return pickerViewMiddle + value
        
    }

}











