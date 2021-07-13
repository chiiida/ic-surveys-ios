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
        var navViewController: SpyNavigationController!

        describe("a SurveyDetailRouter") {
            beforeEach {
                viewController = SurveyDetailViewController()
                viewController.output = SurveyDetailViewOutputMock()

                router = SurveyDetailRouter()
                router.view = viewController
                _ = viewController.view
            }
            
            describe("its showSurveyQuestion is called") {
                context("when the parameter is valid id and question") {
                    beforeEach {
                        let id = "d5de6a8f8f5f1cfe51bc"
                        let questions: [SurveyQuestion] = [.dummy]

                        navViewController = SpyNavigationController(rootViewController: viewController)
                        router.showSurveyQuestion(id: id, questions: questions)
                    }

                    it("pushes a SurveyQuestionModule view") {
                        expect(navViewController.pushedViewController).to(beAKindOf(SurveyQuestionViewController.self))
                    }
                }
            }
        }
    }
}
