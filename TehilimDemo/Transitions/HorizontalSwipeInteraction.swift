//
//  HorizontalSwipeInteraction.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 24/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

var horizontalSwipeGestureKey: String = "HorizontalSwipeGestureKey"

class HorizontalSwipeInteraction: UIPercentDrivenInteractiveTransition {
    var isInteractionInProgress: Bool = false
    private var shouldCompleteTransition: Bool = false
    fileprivate weak var viewController: UIViewController!
    
    
    func wire(to viewController: UIViewController) {
        self.viewController = viewController
        prepareGestureRecognizer(in: viewController.view)
    }
    
    func prepareGestureRecognizer(in view: UIView) {
        
        var gesture: UIPanGestureRecognizer? = objc_getAssociatedObject(view, &horizontalSwipeGestureKey) as? UIPanGestureRecognizer
        if gesture != nil {
            view.removeGestureRecognizer(gesture!)
        }
        gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleGesture))
        view.addGestureRecognizer(gesture!)
        objc_setAssociatedObject(view, &horizontalSwipeGestureKey, gesture, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
    
    
    func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation: CGPoint = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var vel: CGPoint = gestureRecognizer.velocity(in: gestureRecognizer.view)
        
        if let pre = Locale.current.languageCode, pre == "he" {
            vel.x = -vel.x
        }
        
        var progress = fabs(translation.x / 300)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
            
        case .began:
            let rightToLeftSwipe: Bool = vel.x < 0
            isInteractionInProgress = true
            // perform the required navigation operation ...
            // for tab controllers, we need to determine which direction to transition
            if rightToLeftSwipe {
                if (viewController.tabBarController?.selectedIndex)! < (viewController.tabBarController?.viewControllers?.count)! - 1 {
                    viewController.tabBarController?.selectedIndex += 1
                    viewController.tabBarController?.observeValue(forKeyPath: "selectedViewController", of: nil, change: nil, context: nil)
                }
            }
            else {
                if (viewController.tabBarController?.selectedIndex)! > 0 {
                    viewController.tabBarController?.selectedIndex -= 1
                }
            }
        case .changed:
            // compute the current position
            
            shouldCompleteTransition = progress > 0.5
            
            // if an interactive transitions is 100% completed via the user interaction, for some reason
            // the animation completion block is not called, and hence the transition is not completed.
            // This glorious hack makes sure that this doesn't happen.
            // see: https://github.com/ColinEberhardt/VCTransitionsLibrary/issues/4
            if progress >= 1.0 {
                progress = 0.99
            }
            
            update(progress)
        case .cancelled:
            isInteractionInProgress = false
            cancel()
        case .ended:
            isInteractionInProgress = false
            if !shouldCompleteTransition {
                cancel()
            } else {
                finish()
            }
            
        default:
            break
        }
        
    }
}
