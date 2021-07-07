//
//  UIViewController+NavigationItem.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//

import UIKit

extension UIViewController {

    func setUpBackButton(tintColor: UIColor) {
        let backImage = Asset.whiteArrow()?
            .withRenderingMode(.alwaysTemplate)
            .withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -14.0, bottom: 0.0, right: 0.0))
        
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.backBarButtonItem?.title = ""
    }
    
    func setUpCloseButton(viewController: UIViewController, selector: Selector? = #selector(didTapBackButton)) {
        let closeImage = Asset.closeIcon()?
            .withRenderingMode(.alwaysTemplate)
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: closeImage,
            style: .plain,
            target: viewController,
            action: selector
        )
    }

    func setUpTransparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = ""
    }
}

extension UIViewController {

    @objc func didTapBackButton() {
        if navigationController?.viewControllers.count == 1 {
            navigationController?.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
