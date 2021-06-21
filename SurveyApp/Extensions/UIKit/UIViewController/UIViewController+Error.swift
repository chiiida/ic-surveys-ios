//
//  UIViewController+Error.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/18/21.
//

import UIKit

protocol ErrorShowable {
    
    func showError(message: String)
}

extension ErrorShowable where Self: UIViewController {
    
    func showError(message: String) {
        let errorView = ErrorView()
        errorView.setErrorMessage(message)
        errorView.show(on: self.view)
    }
}
