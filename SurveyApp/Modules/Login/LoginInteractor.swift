//
//  LoginInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/7/21.
//  
//

// sourcery: AutoMockable
protocol LoginInteractorInput: AnyObject {
}

// sourcery: AutoMockable
protocol LoginInteractorOutput: AnyObject {
}

final class LoginInteractor {

    weak var output: LoginInteractorOutput?
}

// MARK: - LoginInteractorInput

extension LoginInteractor: LoginInteractorInput {
}
