//
//  UIViewController+Error.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/18/21.
//

import UIKit

protocol ShowErrorView {
    
    func showError(message: String)
}

extension ShowErrorView where Self: UIViewController {
    
    func showError(message: String) {
        let errorView = ErrorView()
        errorView.setErrorMessage(message)
        errorView.show(on: self.view)
    }
}
