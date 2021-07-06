//
//  SurveyDetailRouterSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 7/1/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SurveyDetailRouterSpec: QuickSpec {

    override func spec() {

        var router: SurveyDetailRouter!
        var viewController: SurveyDetailViewController!

        describe("a SurveyDetailRouter") {
            beforeEach {
                viewController = SurveyDetailViewController()
                viewController.output = SurveyDetailViewOutputMock()

                router = SurveyDetailRouter()
                router.view = viewController
                _ = viewController.view
            }
        }
    }
}
