//
//  UIViewController+Alert.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/6/21.
//

import UIKit

extension UIViewController {
    
    func showYesCancelAlert(
        title: String? = nil,
        message: String? = nil,
        yesHandler: CompletionHandler? = nil
    ) {
        let yesAction = UIAlertAction(title: Localize.alertConfirmYes(), style: .default, handler: yesHandler)
        let cancelAction = UIAlertAction(title: Localize.alertConfirmCancel(), style: .default, handler: nil)

        showAlert(
            title: title,
            message: message,
            actions: [yesAction, cancelAction],
            preferredAction: cancelAction
        )
    }

    func showAlert(
        title: String? = nil,
        message: String? = nil,
        actions: [UIAlertAction] = [],
        preferredAction: UIAlertAction? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }

        if let preferredAction = preferredAction, actions.contains(preferredAction) {
            alert.preferredAction = preferredAction
        }
        
        self.present(alert, animated: true)
    }
}
