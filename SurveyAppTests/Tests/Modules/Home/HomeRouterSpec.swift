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
        var navViewController: SpyNavigationController!

        describe("a HomeRouter") {
            beforeEach {
                viewController = HomeViewController()
                viewController.output = HomeViewOutputMock()

                router = HomeRouter()
                router.view = viewController
                _ = viewController.view
            }
            
            describe("its showSurveyDetail is called") {
                context("when the parameter is valid survey") {
                    beforeEach {
                        let surveys: [Survey] = JSON.SurveyService.surveyModelList.decoded()
                        
                        navViewController = SpyNavigationController(rootViewController: viewController)
                        router.showSurveyDetail(survey: surveys[0])
                    }

                    it("pushes a SurveyDetailModule view") {
                        expect(navViewController.pushedViewController).to(beAKindOf(SurveyDetailViewController.self))
                    }
                }
            }
        }
    }
}
