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


    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var dediLabel: UILabel!

    @IBOutlet weak var notDediButton: UIButton!

    @IBAction func notDediButtonAction(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "DonationViewController") as! DonationViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    var arrDedication: [Dedication]? = []
    
    let transition = BubbleTransition()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dediLabel.layer.cornerRadius = 5.0
        dediLabel.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUI), name: .dedicationFetched, object: nil)
        refreshUI()

    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dedi" {
            let controller = segue.destination
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
        }
   
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func refreshUI(){
        dediLabel.isHidden = true
        notDediButton.isHidden = true
        arrDedication = FBManager.manager.fetchedDedications
        if arrDedication != nil && !arrDedication!.isEmpty {
            dediLabel.text = arrDedication![0].text
            dediLabel.isHidden = false
        } else {
            notDediButton.isHidden = false
        }
    }
}

extension DedicationsViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = tapGesture.location(in: self.view.superview?.superview)
        transition.bubbleColor = dediLabel.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.bubbleColor = dediLabel.backgroundColor!
        return transition
    }
}





















