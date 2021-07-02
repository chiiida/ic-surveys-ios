//
//  SurveyDetailRouter.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//  
//

import UIKit

// sourcery: AutoMockable
protocol SurveyDetailRouterInput: AnyObject {
}

final class SurveyDetailRouter {

    weak var view: SurveyDetailViewInput?

    private var viewController: UIViewController? {
        view as? UIViewController
    }
}

// MARK: - SurveyDetailRouterInput

extension SurveyDetailRouter: SurveyDetailRouterInput {
}
