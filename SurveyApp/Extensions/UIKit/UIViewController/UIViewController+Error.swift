//
//  UIViewController+Error.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/18/21.
//

import UIKit

protocol ViewInput {
    
    func showError(message: String)
}

extension ViewInput where Self: UIViewController {
    
    func showError(message: String) {
        let errorView = ErrorView()
        errorView.setErrorMessage(message)
        errorView.show(on: self.view)
    }
}
