//
//  SplashRouterSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/24/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SplashRouterSpec: QuickSpec {

    override func spec() {

        var router: SplashRouter!
        var viewController: SplashViewController!
        var window: UIWindow!

        describe("a SplashRouter") {
            beforeEach {
                viewController = SplashViewController()
                viewController.output = SplashViewOutputMock()

                router = SplashRouter()
                router.view = viewController
                _ = viewController.view
                
                window = UIWindow()
                window.addSubview(viewController.view)
            }
            
            describe("its showLogin is called") {
                beforeEach {
                    router.showLogin()
                }

                it("shows a LoginModule view") {
                    expect((window?.rootViewController as? UINavigationController)?
                            .viewControllers.first).to(beAKindOf(LoginViewController.self))
                }
            }
            
            describe("its showHome is called") {
                beforeEach {
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
