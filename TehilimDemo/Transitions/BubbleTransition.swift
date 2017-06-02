//
//  BubbleTransition.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 21/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class BubbleTransition: NSObject {
    
    enum BubbleTransitionMode {
        case present, dismiss
    }
    
    fileprivate(set) var bubble = UIView()
    var startingPoint = CGPoint.zero {
        didSet{
            bubble.center = startingPoint
        }
    }
    
    var duration = 0.2
    var transitionMode: BubbleTransitionMode = .present
    var bubbleColor: UIColor = .white
}

extension BubbleTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        fromViewController?.beginAppearanceTransition(false, animated: true)
        toViewController?.beginAppearanceTransition(true, animated: true)
        
        switch transitionMode {
        case .present:
            let presentedControllerView = transitionContext.view(forKey: .to)!
            let originalCenter = presentedControllerView.center
            let originalSize = presentedControllerView.frame.size
            
            bubble = UIView()
            bubble.frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            bubble.layer.cornerRadius = bubble.frame.size.height / 2
            bubble.center = startingPoint
            
            
            bubble.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            bubble.backgroundColor = bubbleColor
            containerView.addSubview(bubble)
            
            presentedControllerView.center = startingPoint
            presentedControllerView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            presentedControllerView.alpha = 0
            containerView.addSubview(presentedControllerView)
            
            UIView.animate(withDuration: duration, animations: {
                self.bubble.transform = CGAffineTransform.identity
                presentedControllerView.transform = CGAffineTransform.identity
                presentedControllerView.alpha = 1
                presentedControllerView.center = originalCenter
            }, completion: { (_) in
                transitionContext.completeTransition(true)
                self.bubble.isHidden = true
                fromViewController?.endAppearanceTransition()
                toViewController?.endAppearanceTransition()
            })
        case .dismiss:
            let returningControllerView = transitionContext.view(forKey: .from)!
            let originalCenter = returningControllerView.center
            let originalSize = returningControllerView.frame.size
            
            bubble.frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            bubble.layer.cornerRadius = bubble.frame.size.height / 2
            bubble.center = self.startingPoint
            bubble.isHidden = false
            
            UIView.animate(withDuration: duration, animations: {
                returningControllerView.center = self.startingPoint
                returningControllerView.alpha = 0
            }, completion: { (_) in
                returningControllerView.center = originalCenter
                returningControllerView.removeFromSuperview()
                self.bubble.removeFromSuperview()
                transitionContext.completeTransition(true)
                
                fromViewController?.endAppearanceTransition()
                toViewController?.endAppearanceTransition()
            })
        }
    }
}

private extension BubbleTransition {
    func frameForBubble(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
        let lengthX = fmax(start.x, originalSize.width - start.x)
        let lengthY = fmax(start.y, originalSize.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
























