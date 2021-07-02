//
//  HomeScreenSpec.swift
//  SurveyAppUITests
//
//  Created by Chananchida F. on 7/2/21.
//

import Quick
import Nimble

class HomeScreenSpec: QuickSpec {
    
    override func spec() {
        var app: XCUIApplication!
        
        describe("a Survey app") {
            describe("its Home Screen is shown") {
                beforeEach {
                    self.continueAfterFailure = false
                    
                    app = XCUIApplication()
                    app.needClearUserSession = true
                    app.isUserLoggedIn = true
                    app.mockAPI(
                        withMethod: .get,
                        endPoint: "/api/v1/surveys",
                        willReturnStatus: true,
                        response: JSON.SurveyService.fetchSurveysSuccess
                    )
                    app.launch()
                }
                
                context("when first time Home Screen show") {
                    it("shows first survey detail") {
                        expect(app.staticTexts[TestConstants.Home.surveyCellTitle].label) == "Scarlett Bangkok"
                    }
                }
                
                context("when swipe right one time") {
                    beforeEach {
                        app.collectionViews[TestConstants.Home.collectionView]
                            .swipeLeft()
                    }
                    
                    it("shows another survey detail") {
                        expect(app.staticTexts[TestConstants.Home.surveyCellTitle].label) == "ibis Bangkok Riverside"
                    }
                }
            }
        }
    }
}
