//
//  DedicationsViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 16/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit
import FirebaseCore

class DedicationsViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    var textMyDedication: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainView.layer.cornerRadius = 5.0
        mainView.layer.shadowColor = UIColor.init(red: 40/255, green: 40/255, blue: 40/255, alpha: 1).cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        mainView.layer.shadowOpacity = 1.0
        
        
        mainView.isHidden = true
        FBManager.manager.readMyDedication { (array) in
            guard let array = array else {
                return
            }
            self.textMyDedication = array
            self.firstLabel.text = self.textMyDedication[0]
            self.secondLabel.text = self.textMyDedication[1]
            self.thirdLabel.text = self.textMyDedication[2]
            self.mainView.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dedicationSegue",
            let nvc = segue.destination as? UINavigationController,
            let nextVC = nvc.topViewController as? AddDedicaceViewController {
            
            nextVC.dedications = textMyDedication
            
        }
    }

}





















