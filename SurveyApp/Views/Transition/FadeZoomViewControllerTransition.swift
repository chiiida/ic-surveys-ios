//
//  FadeViewControllerTransition.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/30/21.
//

import Foundation
import UIKit

protocol ZoomableBackgroundViewController {

    var backgroundView: UIView? { get }
}

class FadeZoomViewControllerTransition: NSObject, UIViewControllerAnimatedTransitioning {

    var operation: UINavigationController.Operation = .none
    
    private let animationDuration = 0.3
    
    weak var storedContext: UIViewControllerContextTransitioning?

    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        storedContext = transitionContext
        
        if operation == .pop {
            animateFadeZoomOut(using: transitionContext)
        } else {
            animateFadeZoomIn(using: transitionContext)
        }
    }
    
    func animateFadeZoomIn(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.cancelInteractiveTransition()
            return transitionContext.completeTransition(false)
        }
        transitionContext.containerView.addSubview(toVC.view)
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = transitionDuration(using: transitionContext)
        fadeIn.delegate = self
        toVC.view.layer.add(fadeIn, forKey: nil)
        
        let zoomIn = CABasicAnimation(keyPath: "transform.scale")
        zoomIn.fromValue = 1.0
        zoomIn.toValue = 1.5
        zoomIn.fillMode = .forwards
        zoomIn.isRemovedOnCompletion = false
        zoomIn.duration = transitionDuration(using: transitionContext)
        let transitionBackground = toVC as? ZoomableBackgroundViewController
        transitionBackground?.backgroundView?.layer.add(zoomIn, forKey: nil)
    }
    
    func animateFadeZoomOut(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            transitionContext.cancelInteractiveTransition()
            return transitionContext.completeTransition(false)
        }
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = transitionDuration(using: transitionContext)
        fadeOut.delegate = self
        fromView.layer.add(fadeOut, forKey: nil)
        
        let zoomOut = CABasicAnimation(keyPath: "transform.scale")
        zoomOut.fromValue = 1.5
        zoomOut.toValue = 1.0
        zoomOut.fillMode = .forwards
        zoomOut.isRemovedOnCompletion = false
        zoomOut.duration = transitionDuration(using: transitionContext)
        let transitionBackground = fromVC as? ZoomableBackgroundViewController
        transitionBackground?.backgroundView?.layer.add(zoomOut, forKey: nil)
    }
}

extension FadeZoomViewControllerTransition: CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let context = storedContext {
            if context.transitionWasCancelled {
                context.cancelInteractiveTransition()
            } else {
                context.finishInteractiveTransition()
            }
            context.completeTransition(!context.transitionWasCancelled)
        }
        storedContext = nil
    }
}
