//
//  HomeViewControllerSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/28/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class HomeViewControllerSpec: QuickSpec {

    override func spec() {

        var viewController: HomeViewController!
        var output: HomeViewOutputMock!

        describe("a HomeViewController") {
            beforeEach {
                output = HomeViewOutputMock()

                viewController = HomeViewController()
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
