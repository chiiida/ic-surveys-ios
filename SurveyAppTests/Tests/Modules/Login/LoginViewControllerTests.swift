//
//  LoginViewControllerTests.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/17/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class LoginViewControllerTests: QuickSpec {
    
    override func spec() {
        var viewController: LoginViewController!
        var output: LoginViewOutputMock!
        
        describe("LoginViewController") {
            
            beforeEach {
                output = LoginViewOutputMock()
                
                viewController = LoginViewController()
                viewController.output = output
            }
            
            context("when viewDidLoad() is called") {

                beforeEach {
                    viewController.viewDidLoad()
                }

                it("calls presenter viewDidLoad()") {
                    expect(output.viewDidLoadCalled) == true
                }
            }
        }
    }
}
