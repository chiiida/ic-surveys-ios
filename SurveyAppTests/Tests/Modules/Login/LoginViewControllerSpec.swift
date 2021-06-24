//
//  LoginViewControllerSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/17/21.
//

import Quick
import Nimble

@testable import SurveyApp

final class LoginViewControllerSpec: QuickSpec {

    override func spec() {
        var viewController: LoginViewController!
        var output: LoginViewOutputMock!

        describe("a LoginViewController") {
            beforeEach {
                output = LoginViewOutputMock()

                viewController = LoginViewController()
                viewController.output = output
            }

            describe("its viewDidLoad is called") {
                beforeEach {
                    viewController.viewDidLoad()
                }

                it("triggers output to call viewDidLoad") {
                    expect(output.viewDidLoadCalled) == true
                }
            }
        }
    }
}
