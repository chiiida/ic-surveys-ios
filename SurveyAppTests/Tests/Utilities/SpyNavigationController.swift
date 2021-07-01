//
//  SpyNavigationController.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 7/1/21.
//

import UIKit

class SpyNavigationController: UINavigationController {

    var pushedViewController: UIViewController?
    var popedViewController: UIViewController?
    var popedToRoot = false
    var popedToViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        popedViewController = viewControllers.last
        return super.popViewController(animated: animated)
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popedToRoot = true
        return super.popToRootViewController(animated: animated)
    }

    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        popedToViewController = viewController
        return super.popToViewController(viewController, animated: animated)
    }
}
