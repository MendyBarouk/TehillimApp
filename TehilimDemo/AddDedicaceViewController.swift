//
//  AddDedicaceViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 16/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class AddDedicaceViewController: UIViewController {

    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var myView: UIView!
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //scrollview.contentSize = view.frame.size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if let dedications = FBManager.manager.fetchedDedications {
            
            guard let label = myView.subviews[0] as? UILabel else { return }
            guard let textView = myView.subviews[1] as? UITextView else { return }
            
            label.text = dedications[0].text
            textView.text = dedications[0].longText
            
            
            myView.layer.cornerRadius = 5.0
            myView.layer.shadowColor = UIColor.init(red: 40/255, green: 40/255, blue: 40/255, alpha: 1).cgColor
            myView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            myView.layer.shadowOpacity = 1.0
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "dedications".localizedString
    }

}

















