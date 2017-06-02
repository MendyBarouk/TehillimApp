//
//  DonationViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 17/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit
import MessageUI

class DonationViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var topLabel: MyLabel!
    @IBOutlet weak var maintDediTextField: UITextField!
    @IBOutlet weak var cunterMainDediLabel: UILabel!
    @IBOutlet weak var detailDediTextView: UITextView!
    @IBOutlet weak var dateDediTextField: UITextField!
    @IBOutlet weak var otherTextView: UITextView!
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        if maintDediTextField.isFirstResponder {
            maintDediTextField.resignFirstResponder()
        } else if detailDediTextView.isFirstResponder {
            detailDediTextView.resignFirstResponder()
        } else if dateDediTextField.isFirstResponder {
            dateDediTextField.resignFirstResponder()
        } else if otherTextView.isFirstResponder {
            otherTextView.resignFirstResponder()
        }
    }
    
    func sendButtonAction() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["tehilimappios@gmail.com"])
            mail.setSubject("donation_to_dedication".localizedString)
            guard let body = prepareTheBody() else {
                return
            }
            mail.setMessageBody(body, isHTML: false)
            present(mail, animated: true, completion: nil)
        } else {
            debugPrint("sa marche pas!")
        }

    }
    
    func prepareTheBody() -> String? {
        var body = ""
        guard let mainDedi = maintDediTextField.text, !mainDedi.isEmpty else {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 85, height: 12))
            label.text = "required_field".localizedString
            label.textColor = .red
            label.font = UIFont.systemFont(ofSize: 12)
            maintDediTextField.rightViewMode = .whileEditing
            maintDediTextField.rightView = label
            maintDediTextField.becomeFirstResponder()
            return nil
        }
        body += "Main dedication:\t\(mainDedi)\n"
        if detailDediTextView.textColor != UIColor.lightGray && !detailDediTextView.text.isEmpty {
            body += "Detail of the dedication:\t\(detailDediTextView.text!)\n"
        }
        guard let date = dateDediTextField.text, !date.isEmpty else {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 85, height: 12))
            label.text = "required_field".localizedString
            label.textColor = .red
            label.font = UIFont.systemFont(ofSize: 12)
            dateDediTextField.rightViewMode = .whileEditing
            dateDediTextField.rightView = label
            dateDediTextField.becomeFirstResponder()
            return nil
        }
        body += "For the: \(date)\n"
        if otherTextView.textColor != UIColor.lightGray && !otherTextView.text.isEmpty {
            body += "Other:\t\(otherTextView.text!)\n"
        }
        body += "price".localizedString + "\n"
        return body
    }
    
    var keyboardIsAppear = false
    func keyboardWillAppear(notification: Notification) {
        if self.view.frame.size.height < 800 && !keyboardIsAppear {
            self.view.frame.origin.y -= (topLabel.frame.origin.y + topLabel.frame.size.height) - (navigationController?.navigationBar.frame.size.height)! - 10
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            keyboardIsAppear = true
        }
    }
    
    func keyboardWillDisappear(notification: Notification) {
        if self.view.frame.size.height < 800 && keyboardIsAppear {
            self.view.frame.origin.y += (topLabel.frame.origin.y + topLabel.frame.size.height) - (navigationController?.navigationBar.frame.size.height)! - 10
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            keyboardIsAppear = false
        }
    }
    
    func configureInputViewForDateDedi() {
        configureToolBar()
        configureDateInput()
    }
    
    func configureDateInput() {
        datePicker.calendar = Calendar(identifier: .hebrew)
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en")
        let now = Date()
        var startComponent = DateComponents()
        startComponent.day = 1
        let minDate = datePicker.calendar.date(byAdding: startComponent, to: now)
        
        
        var endComponent = DateComponents()
        endComponent.year = 1
        let maxDate = datePicker.calendar.date(byAdding: endComponent, to: now)!
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        
        datePicker.backgroundColor = UIColor.darkGray
        let color = UIColor.init(red: 213/255, green: 245/255, blue: 162/255, alpha: 1)
        datePicker.setValue(color, forKey: "textColor")
        datePicker.addTarget(self, action: #selector(refreshDateTextField), for: .valueChanged)
        
        dateDediTextField.inputView = datePicker
    }
    
    func configureToolBar() {
        let width = UIApplication.shared.delegate!.window!!.bounds.width
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let hebrewItem = UIBarButtonItem(title: "jewish_cal".localizedString, style: .plain, target: self, action: #selector(hebrewOrGregItemAction(_:)))
        let gregItem = UIBarButtonItem(title: "gregorian_cal".localizedString, style: .plain, target: self, action: #selector(hebrewOrGregItemAction(_:)))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneItemAction))
        
        hebrewItem.tag = 0
        gregItem.tag = 1
        
        toolbar.barStyle = .blackTranslucent
        toolbar.tintColor = UIColor.init(red: 213/255, green: 245/255, blue: 162/255, alpha: 1)
        
        toolbar.items = [hebrewItem,gregItem,spaceItem,doneItem]
        
        dateDediTextField.inputAccessoryView = toolbar
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
        dateDediTextField.inputView = datePicker
        dateDediTextField.reloadInputViews()
        refreshDateTextField()
    }
    
    
    func refreshDateTextField() {
        let formatter = DateFormatter()
        formatter.locale = datePicker.locale
        formatter.dateStyle = .long
        formatter.calendar = datePicker.calendar
        dateDediTextField.text = formatter.string(from: datePicker.date)
    }
    
    func doneItemAction() {
        refreshDateTextField()
        otherTextView.becomeFirstResponder()
    }
    
    func configureTextViews() {
        detailDediTextView.text = "text_dedication_screen".localizedString
        detailDediTextView.textColor = UIColor.lightGray
        detailDediTextView.tag = 0
        detailDediTextView.delegate = self
        
        otherTextView.text = "information_ask_here".localizedString
        otherTextView.textColor = UIColor.lightGray
        otherTextView.tag = 1
        otherTextView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let sendButton = UIBarButtonItem(image: #imageLiteral(resourceName: "send"), style: .done, target: self, action: #selector(sendButtonAction))
        navigationItem.rightBarButtonItem = sendButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor.init(red: 213/255, green: 245/255, blue: 162/255, alpha: 1)
        navigationItem.title = "donation_to_dedication".localizedString
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        maintDediTextField.delegate = self
        maintDediTextField.placeholder = "text_of_dedication_placeholder".localizedString
        dateDediTextField.placeholder = "date_of_dedication_placeholder".localizedString
        configureTextViews()
        configureInputViewForDateDedi()
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITextfieldDelegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        detailDediTextView.becomeFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let length = text.characters.count + string.characters.count - range.length
        
        let count = 66 - length
        
        if count >= 0 {
            cunterMainDediLabel.text =  String(count)
        }

        
        return length <= 66
    }
    
    // MARK: - UITextViewDelegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        return true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            switch textView.tag {
            case 0:
                detailDediTextView.text = "text_dedication_screen".localizedString
                detailDediTextView.textColor = UIColor.lightGray
                return
            case 1:
                otherTextView.text = "information_ask_here".localizedString
                otherTextView.textColor = UIColor.lightGray
                return
            default:
                return
            }
        }

    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            switch textView.tag {
            case 0:
                detailDediTextView.text = "text_dedication_screen".localizedString
                detailDediTextView.textColor = UIColor.lightGray
                detailDediTextView.resignFirstResponder()
                return
            case 1:
                otherTextView.text = "information_ask_here".localizedString
                otherTextView.textColor = UIColor.lightGray
                otherTextView.resignFirstResponder()
                return
            default:
                return
            }
        }

    }
}







