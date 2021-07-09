//
//  SurveyDetailInteractorSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 7/1/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SurveyDetailInteractorSpec: QuickSpec {

    override func spec() {

        var interactor: SurveyDetailInteractor!
        var output: SurveyDetailInteractorOutputMock!
        var surveyService: SurveyServiceProtocolMock!

        describe("a SurveyDetailInteractor") {
            beforeEach {
                output = SurveyDetailInteractorOutputMock()
                surveyService = SurveyServiceProtocolMock()
                
                interactor = SurveyDetailInteractor(surveyService: surveyService)
                interactor.output = output
            }
        }
    }
}
