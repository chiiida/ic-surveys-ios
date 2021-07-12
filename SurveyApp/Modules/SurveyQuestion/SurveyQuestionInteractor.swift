//
//  SurveyQuestionInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//  
//

// sourcery: AutoMockable
protocol SurveyQuestionInteractorInput: AnyObject {
}

// sourcery: AutoMockable
protocol SurveyQuestionInteractorOutput: AnyObject {
}

final class SurveyQuestionInteractor {

    weak var output: SurveyQuestionInteractorOutput?
}

// MARK: - SurveyQuestionInteractorInput

extension SurveyQuestionInteractor: SurveyQuestionInteractorInput {
}
