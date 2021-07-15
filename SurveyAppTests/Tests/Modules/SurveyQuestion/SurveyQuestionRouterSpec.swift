//
//  SurveyQuestionRouterSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 7/12/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SurveyQuestionRouterSpec: QuickSpec {

    override func spec() {

        var router: SurveyQuestionRouter!
        var viewController: SurveyQuestionViewController!

        describe("a SurveyQuestionRouter") {
            beforeEach {
                viewController = SurveyQuestionViewController()
                viewController.output = SurveyQuestionViewOutputMock()

                router = SurveyQuestionRouter()
                router.view = viewController
                _ = viewController.view
            }
        }
    }
}
