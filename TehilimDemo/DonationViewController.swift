//
//  DonationViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 17/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit
import MessageUI

class DonationViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    func sendButtonAction() {
    
        let googleUrlString = "googlegmail:///co?to=mendibarouk@gmail.com&subject=dont%20pour%20une%20dedicace&body=Hi"
        if let googleUrl = NSURL(string: googleUrlString), UIApplication.shared.canOpenURL(googleUrl as URL) {
            // show alert to choose app
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(googleUrl as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(googleUrl as URL)
            }
        } else if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["mendibarouk@gmail.com"])
            mail.setSubject("Don pour une dedicace")
            mail.setMessageBody("<h1>Sa Marche?</h1>", isHTML: true)
            present(mail, animated: true, completion: nil)
        } else {
            debugPrint("sa marche pas!")
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let sendButton = UIBarButtonItem(image: #imageLiteral(resourceName: "send"), style: .done, target: self, action: #selector(sendButtonAction))
        navigationItem.rightBarButtonItem = sendButton
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print(result)
        print(error ?? "pas d'erreur")
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
