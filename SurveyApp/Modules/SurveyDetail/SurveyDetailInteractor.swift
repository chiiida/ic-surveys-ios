//
//  SurveyDetailInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//  
//

// sourcery: AutoMockable
protocol SurveyDetailInteractorInput: AnyObject {
}

// sourcery: AutoMockable
protocol SurveyDetailInteractorOutput: AnyObject {
}

final class SurveyDetailInteractor {

    weak var output: SurveyDetailInteractorOutput?
}

// MARK: - SurveyDetailInteractorInput

extension SurveyDetailInteractor: SurveyDetailInteractorInput {
}
