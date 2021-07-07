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
    
    func showSurveyQuestion()
}

final class SurveyDetailRouter {

    weak var view: SurveyDetailViewInput?

    private var viewController: UIViewController? {
        view as? UIViewController
    }
}

// MARK: - SurveyDetailRouterInput

extension SurveyDetailRouter: SurveyDetailRouterInput {
    
    func showSurveyQuestion() {
        let module = SurveyQuestionModule()
        viewController?.navigationController?.pushViewController(module.view, animated: true)
    }
}
