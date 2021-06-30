//
//  HomeRouterSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/28/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class HomeRouterSpec: QuickSpec {

    override func spec() {

        var router: HomeRouter!
        var viewController: HomeViewController!

        describe("a HomeRouter") {
            beforeEach {
                viewController = HomeViewController()
                viewController.output = HomeViewOutputMock()

                router = HomeRouter()
                router.view = viewController
                _ = viewController.view
            }
        }
    }
}
