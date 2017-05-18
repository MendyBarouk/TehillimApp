//
//  AddDedicaceViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 16/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class AddDedicaceViewController: UIViewController {

    var dedications: [String] = []
    
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var firstTextView: UITextView!
    @IBOutlet weak var secondTextView: UITextView!
    @IBOutlet weak var thirdTextView: UITextView!
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //scrollview.contentSize = view.frame.size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        firstLabel.text = dedications[0]
        secondLabel.text = dedications[1]
        thirdLabel.text = dedications[2]
        firstTextView.text = dedications[3]
        secondTextView.text = dedications[4]
        thirdTextView.text = dedications[5]
        
        for v in views {
            v.layer.cornerRadius = 5.0
            v.layer.shadowColor = UIColor.init(red: 40/255, green: 40/255, blue: 40/255, alpha: 1).cgColor
            v.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            v.layer.shadowOpacity = 1.0
        }
    }

}

















