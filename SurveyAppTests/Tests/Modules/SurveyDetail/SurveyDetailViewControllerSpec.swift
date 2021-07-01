//
//  SurveyDetailViewControllerSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 7/1/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SurveyDetailViewControllerSpec: QuickSpec {

    override func spec() {

        var viewController: SurveyDetailViewController!
        var output: SurveyDetailViewOutputMock!

        describe("a SurveyDetailViewController") {
            beforeEach {
                output = SurveyDetailViewOutputMock()

                viewController = SurveyDetailViewController()
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
