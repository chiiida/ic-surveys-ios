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
                    app.isUserLoggedIn = true
                    app.mockAPI(
                        withMethod: .get,
                        endPoint: "/api/v1/surveys",
                        willReturnStatus: true,
                        response: JSON.SurveyService.fetchSurveysSuccess
                    )
                    app.launch()
                }
                
                context("when Home Screen shows for the first time") {
                    it("shows first survey detail") {
                        expect(app.staticTexts[TestConstants.Home.surveyCellTitle].label) == "Scarlett Bangkok"
                    }
                }
                
                context("when swipe left one time") {
                    beforeEach {
                        sleep(2)
                        app.collectionViews[TestConstants.Home.collectionView]
                            .swipeLeft()
                    }
                    
                    it("shows second survey detail") {
                        expect(app.staticTexts[TestConstants.Home.surveyCellTitle].label) == "ibis Bangkok Riverside"
                    }
                }
                
                context("when press on survey detail button") {
                    beforeEach {
                        sleep(2)
                        app.buttons[TestConstants.Home.surveyDetailButton]
                            .tap()
                    }
                    
                    it("shows Survey Detail Screen") {
                        expect(app.otherElements[TestConstants.SurveyDetail.surveyDetailView].exists) == true
                    }
                }
            }
        }
    }
}
