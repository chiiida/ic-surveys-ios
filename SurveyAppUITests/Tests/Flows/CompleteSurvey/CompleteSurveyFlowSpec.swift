//
//  CompleteSurveyFlowSpec.swift
//  SurveyAppUITests
//
//  Created by Chananchida F. on 7/14/21.
//

import Quick
import Nimble

class CompleteSurveyFlowSpec: QuickSpec {
    
    override func spec() {
        var app: XCUIApplication!
        
        describe("a Survey app") {
            context("when go through complete survey flow successfully") {
                beforeEach {
                    self.continueAfterFailure = false
                    
                    app = XCUIApplication()
                    app.isUserLoggedIn = true
                    app.setUpMockAPIs()
                    app.launch()
                    
                    app.buttons[TestConstants.Home.surveyDetailButton]
                        .tap()
                    app.buttons[TestConstants.SurveyDetail.startSurveyButton]
                        .tap()
                    app.pickers[TestConstants.SurveyQuestion.pickerView]
                        .swipeUp()
                    app.collectionViews[TestConstants.SurveyQuestion.collectionView]
                        .swipeLeft()
                    app.textViews[TestConstants.SurveyQuestion.multilineTextView]
                        .tapThen()
                        .typeText("Comment")
                    app.toolbars.buttons[TestConstants.Toolbar.keyboardDonebutton]
                        .tap()
                    app.buttons[TestConstants.SurveyQuestion.submitSurveyButton]
                        .tap()
                }
                
                it("shows Lottie Complete Survey Screen") {
                    expect(app.otherElements[TestConstants.SurveyQuestion.lottieCompleteSurveyView].exists) == true
                }
            }
        }
    }
}

fileprivate extension XCUIApplication {
    
    func setUpMockAPIs() {
        mockAPI(
            withMethod: .get,
            endPoint: "/api/v1/surveys",
            willReturnStatus: true,
            response: JSON.SurveyService.fetchSurveysSuccess
        )
        mockAPI(
            withMethod: .get,
            endPoint: "/api/v1/surveys/d5de6a8f8f5f1cfe51bc",
            willReturnStatus: true,
            response: JSON.SurveyService.fetchSurveyDetailSuccess
        )
        mockAPI(
            withMethod: .post,
            endPoint: "/api/v1/responses",
            willReturnStatus: true,
            response: JSON.SurveyService.submitSurveySuccess
        )
    }
}

