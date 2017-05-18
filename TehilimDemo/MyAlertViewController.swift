//
//  MyAlertViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 14/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class MyAlertViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    let datePicker = UIDatePicker()
    let perekPicker = UIPickerView()
    var perekPickerData: [String]!
    var isPerek: Bool!
    weak var delegate: MyAlertViewControllerDelegate?

    // MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dateOrPerekTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Actions
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        guard dateOrPerekTextField.text != nil, !dateOrPerekTextField.text!.isEmpty else {
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 8))
            label.text = "Add a date or chapter"
            label.textColor = .red
            label.font = UIFont.systemFont(ofSize: 8)
            
            dateOrPerekTextField.rightViewMode = .always
            dateOrPerekTextField.rightView = label
            return
        }
        var date: Date?
        var perek: String?
        
        if isPerek {
            perek = perekPickerData[perekPicker.selectedRow(inComponent: 0)]
            
        } else {
            date = datePicker.date
        }
        
        delegate?.saveAlertAction(sender: sender, date: date, perek: perek, name: nameTextField.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        if dateOrPerekTextField.isFirstResponder {
            dateOrPerekTextField.resignFirstResponder()
        } else if nameTextField.isFirstResponder {
            nameTextField.resignFirstResponder()
        }
    }
    
    
    // MARK: - My functions
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.7
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
    }
    
    func keyboardWillAppear(notification: Notification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 110
        }
    }
    
    func keyboardWillDisappear(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 110
        }
    }
    
    func doneItemAction() {
        nameTextField.becomeFirstResponder()
    }

    func configureToolbar() {
        let width = UIApplication.shared.delegate!.window!!.bounds.width
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let hebrewItem = UIBarButtonItem(title: "Hebrew", style: .plain, target: self, action: #selector(hebrewOrGregItemAction(_:)))
        let gregItem = UIBarButtonItem(title: "Grégorian", style: .plain, target: self, action: #selector(hebrewOrGregItemAction(_:)))
        let perekItem = UIBarButtonItem(title: "Perek", style: .plain, target: self, action: #selector(perekItemAction))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneItemAction))
        
        hebrewItem.tag = 0
        gregItem.tag = 1
        
        toolbar.barStyle = .blackTranslucent
        toolbar.tintColor = UIColor.init(red: 213/255, green: 245/255, blue: 162/255, alpha: 1)
        
        toolbar.items = [hebrewItem,gregItem,perekItem,spaceItem,doneItem]
        
        dateOrPerekTextField.inputAccessoryView = toolbar
        
    }
    
    func hebrewOrGregItemAction(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            datePicker.locale = Locale(identifier: "en")
            datePicker.calendar = Calendar(identifier: .hebrew)
        case 1:
            datePicker.locale = Locale.current
            datePicker.calendar = Calendar(identifier: .gregorian)
        default: break
        }
        dateOrPerekTextField.inputView = datePicker
        dateOrPerekTextField.reloadInputViews()
        isPerek = false
        refreshdateOrPerekTextField()
    }
    
    func perekItemAction() {
        dateOrPerekTextField.inputView = perekPicker
        dateOrPerekTextField.reloadInputViews()
        isPerek = true
        refreshdateOrPerekTextField()
    }
    
    func configureDateInput() {
        datePicker.calendar = Calendar(identifier: .hebrew)
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en")
        let now = Date()
        var component = DateComponents()
        component.year = -149
        let minDate = datePicker.calendar.date(byAdding: component, to: now)!
        datePicker.maximumDate = Date()
        datePicker.minimumDate = minDate
        datePicker.backgroundColor = UIColor.darkGray
        let color = UIColor.init(red: 213/255, green: 245/255, blue: 162/255, alpha: 1)
        datePicker.setValue(color, forKey: "textColor")
        isPerek = false
        datePicker.addTarget(self, action: #selector(refreshdateOrPerekTextField), for: .valueChanged)
        
        dateOrPerekTextField.inputView = datePicker
    }
    
    func configurePerekInput() {
        perekPicker.backgroundColor = UIColor.darkGray
        let color = UIColor.init(red: 213/255, green: 245/255, blue: 162/255, alpha: 1)
        perekPicker.setValue(color, forKey: "textColor")
        
        perekPickerData = []
        for i in 0..<150 {
            perekPickerData.append("\(i+1)")
        }

        perekPicker.dataSource = self
        perekPicker.delegate = self
    }
    
    func refreshdateOrPerekTextField() {
        if isPerek {
            dateOrPerekTextField.text = perekPickerData[perekPicker.selectedRow(inComponent: 0)]
        } else {
            let formatter = DateFormatter()
            formatter.locale = datePicker.locale
            formatter.dateStyle = .long
            formatter.calendar = datePicker.calendar
            dateOrPerekTextField.text = formatter.string(from: datePicker.date)
        }
    }
    
    
    // MARK: - iOS Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //addBlurEffect()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        mainView.layer.cornerRadius = 5.0
        dateOrPerekTextField.delegate = self
        nameTextField.keyboardAppearance = .dark
        
        configureToolbar()
        configureDateInput()
        configurePerekInput()
    }
    
    // MARK: - UIPickerViewDataSource
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return perekPickerData.count
    }
    
    // MARK: - UIPickerViewDelegate
    // attributed title is favored if both methods are implemented
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let color = UIColor.init(red: 213/255, green: 245/255, blue: 162/255, alpha: 1)
        let attributesString = NSAttributedString(string: perekPickerData[row], attributes: [NSForegroundColorAttributeName : color])
        return attributesString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        refreshdateOrPerekTextField()
    }
    
    // MARK: - UITextFieldDelegate
    // became first responder
    public func textFieldDidBeginEditing(_ textField: UITextField){
        dateOrPerekTextField.rightViewMode = .never
        refreshdateOrPerekTextField()
    }
}


protocol MyAlertViewControllerDelegate: class {
    func saveAlertAction(sender: UIButton, date: Date?, perek: String?, name: String?)
}


























