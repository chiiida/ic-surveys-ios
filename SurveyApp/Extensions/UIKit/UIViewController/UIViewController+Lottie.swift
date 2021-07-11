//
//  UIViewController+Lottie.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/11/21.
//

import UIKit

protocol LottieShowable {
    
    func showCompleteSurveyView(completion: EmptyCompletion?)
}

extension LottieShowable where Self: UIViewController {
    
    func showCompleteSurveyView(completion: EmptyCompletion? = nil) {
        let completeSurveyView = CompleteSurveyView()
        completeSurveyView.presentViewOnTopWindow(for: 0.8) {
            completion?()
        }
    }
}
