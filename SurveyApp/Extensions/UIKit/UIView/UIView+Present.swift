//
//  UIView+Present.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/11/21.
//

import UIKit

extension UIView {
    
    func presentViewOnTopWindow(_ duration: TimeInterval = 0.3, for dismissAfter: TimeInterval = 0, _ completion: EmptyCompletion? = nil) {
        alpha = 0
        frame = UIScreen.main.bounds
        let windows = UIApplication.shared.windows.first { $0.isKeyWindow }
        windows?.addSubview(self)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: .curveEaseInOut,
            animations: { [weak self] in
                self?.alpha = 1
            },
            completion: { _ in
                if dismissAfter <= 0 {
                    completion?()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) { [weak self] in
                         self?.dismissView(completion)
                    }
                }
            }
        )
    }
    
    func dismissView(with duration: TimeInterval = 0.3, _ completion: EmptyCompletion? = nil) {
        UIView.animate(
            withDuration: duration,
            animations: { [weak self] in
                self?.alpha = 0
            },
            completion: { [weak self] _ in
                completion?()
                self?.removeFromSuperview()
            }
        )
    }
}
