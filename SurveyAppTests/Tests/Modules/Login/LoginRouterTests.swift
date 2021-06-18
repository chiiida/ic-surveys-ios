//
//  LoginRouterTests.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/17/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class LoginRouterTests: QuickSpec {

    override func spec() {
        var router: LoginRouter!
        var viewController: LoginViewController!
        var window: UIWindow!
        
        describe("LoginRouter") {
            
            beforeEach {
                viewController = LoginViewController()
                viewController.output = LoginViewOutputMock()

                router = LoginRouter()
                router.view = viewController
                _ = viewController.view
            }
            
            context("when showHome() is call") {
                beforeEach {
                    window = UIWindow()
                    window.addSubview(viewController.view)
                    router.showHome()
                }

                it("show a HomeModule view") {
                    expect((window?.rootViewController as? UINavigationController)?
                            .viewControllers.first).to(beAKindOf(HomeViewController.self))
                }
            }
        }
    }
}
