//
//  LoginFlowSpec.swift
//  SurveyAppUITests
//
//  Created by Chananchida F. on 7/1/21.
//

import Quick
import Nimble

class LoginFlowSpec: QuickSpec {
    
    override func spec() {
        var app: XCUIApplication!
        
        describe("a Survey app") {
            context("when go through login flow successfully") {
                beforeEach {
                    self.continueAfterFailure = false
                    
                    app = XCUIApplication()
                    app.isUserLoggedIn = true
                    app.mockAPI(
                        withMethod: .post,
                        endPoint: "/api/v1/oauth/token",
                        willReturnStatus: true,
                        response: JSON.AuthenticationService.authenticateEmailSuccess
                    )
                    app.launch()
                    
                    app.textFields[TestConstants.Login.emailInputTextField]
                        .tapThen()
                        .typeText("user@example.com")
                    app.secureTextFields[TestConstants.Login.passwordInputTextField]
                        .tapThen()
                        .typeText("12345678")
                    app.buttons[TestConstants.Login.loginButton]
                        .tap()
                }
                
                it("shows Home screen") {
                    expect(app.otherElements[TestConstants.Home.homeView].exists) == true
                }
            }
        }
    }
}
