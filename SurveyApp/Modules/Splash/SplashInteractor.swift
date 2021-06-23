//
//  SplashInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/23/21.
//  
//

// sourcery: AutoMockable
protocol SplashInteractorInput: AnyObject {
    
    func getLoginInStatus()
}

// sourcery: AutoMockable
protocol SplashInteractorOutput: AnyObject {
    
    func didGetLoginStatus(isLoggedIn: Bool)
}

final class SplashInteractor {

    weak var output: SplashInteractorOutput?
}

// MARK: - SplashInteractorInput

extension SplashInteractor: SplashInteractorInput {
    
    func getLoginInStatus() {
        let isLoggedIn = UserSessionProvider.shared.isLoggedIn
        output?.didGetLoginStatus(isLoggedIn: isLoggedIn)
    }
}
