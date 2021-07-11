//
//  LottieAnimationViews.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/11/21.
//

import UIKit
import Lottie

enum LottieAnimationViews {
    
    static var completeSurveyView: AnimationView {
        let completeSurveyView = AnimationView(name: "AnimatedCompleteSurvey")
        completeSurveyView.contentMode = .scaleAspectFit
        completeSurveyView.backgroundBehavior = .pauseAndRestore
        completeSurveyView.play()
        return completeSurveyView
    }
}
