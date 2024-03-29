//
//  LoginRouterSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/17/21.
//

import Quick
import Nimble

@testable import SurveyApp

final class LoginRouterSpec: QuickSpec {

    override func spec() {
        var router: LoginRouter!
        var viewController: LoginViewController!
        var window: UIWindow!

        describe("a LoginRouter") {
            beforeEach {
                viewController = LoginViewController()
                viewController.output = LoginViewOutputMock()

                router = LoginRouter()
                router.view = viewController
                _ = viewController.view
            }

            describe("its showHome is called") {
                beforeEach {
                    window = UIWindow()
                    window.addSubview(viewController.view)
                    router.showHome()
                }

                it("shows a HomeModule view") {
                    expect((window?.rootViewController as? UINavigationController)?
                            .viewControllers.first).to(beAKindOf(HomeViewController.self))
                }
            }
        }
    }
}
