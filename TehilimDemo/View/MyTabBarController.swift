//
//  MyTabBarController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 27/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    fileprivate let swipeInteractionController = HorizontalSwipeInteraction()
    fileprivate let switchAnimation: SwitchAnimation = SwitchAnimation()
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "selectedViewController" {
            // wire the interaction controller to the view controller
            swipeInteractionController.wire(to: selectedViewController!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        
        // observe changes in the currently presented view controller
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 16)], for: .normal)
        addObserver(self, forKeyPath: "selectedViewController", options: NSKeyValueObservingOptions.new, context: nil)
        
        if let item1 = self.tabBar.items?[0], let item2 = self.tabBar.items?[1] {
            item1.title = "daily".localizedString
            item2.title = "everything".localizedString
        }
        
        self.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 16)], for: .normal)
        
    }
}


extension MyTabBarController: UITabBarControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return swipeInteractionController.isInteractionInProgress ? swipeInteractionController : nil
    }
    
    
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let fromVCIndex = tabBarController.viewControllers?.index(of: fromVC),
            let toVCIndex = tabBarController.viewControllers?.index(of: toVC) else {
                return nil
        }
        
        self.switchAnimation.isReverse = fromVCIndex < toVCIndex
        
        return switchAnimation
        
    }
}



