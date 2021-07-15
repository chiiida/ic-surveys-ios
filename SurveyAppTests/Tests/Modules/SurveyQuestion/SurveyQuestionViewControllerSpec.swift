//
//  SurveyQuestionViewControllerSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 7/12/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SurveyQuestionViewControllerSpec: QuickSpec {

    override func spec() {

        var viewController: SurveyQuestionViewController!
        var output: SurveyQuestionViewOutputMock!

        describe("a SurveyQuestionViewController") {
            beforeEach {
                output = SurveyQuestionViewOutputMock()

                viewController = SurveyQuestionViewController()
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
