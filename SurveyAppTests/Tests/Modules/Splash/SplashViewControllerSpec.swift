//
//  SplashViewControllerSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/24/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SplashViewControllerSpec: QuickSpec {

    override func spec() {

        var viewController: SplashViewController!
        var output: SplashViewOutputMock!

        describe("a SplashViewController") {
            beforeEach {
                output = SplashViewOutputMock()

                viewController = SplashViewController()
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
