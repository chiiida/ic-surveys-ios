//
//  SurveyQuestionRouter.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//  
//

import UIKit

// sourcery: AutoMockable
protocol SurveyQuestionRouterInput: AnyObject {
}

final class SurveyQuestionRouter {

    weak var view: SurveyQuestionViewInput?

    private var viewController: UIViewController? {
        view as? UIViewController
    }
}

// MARK: - SurveyRouterInput

extension SurveyQuestionRouter: SurveyQuestionRouterInput {
}
