//
//  SplashInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/23/21.
//  
//

// sourcery: AutoMockable
protocol SplashInteractorInput: AnyObject {
    
    var isLoggedIn: Bool { get }
}

// sourcery: AutoMockable
protocol SplashInteractorOutput: AnyObject {
}

final class SplashInteractor {

    weak var output: SplashInteractorOutput?
    
    private(set) var userSessionProvider: UserSessionProviderProtocol?
    
    init(userSessionProvider: UserSessionProviderProtocol) {
        self.userSessionProvider = userSessionProvider
    }
}

// MARK: - SplashInteractorInput

extension SplashInteractor: SplashInteractorInput {
    
    var isLoggedIn: Bool {
        guard let isLoggedIn = userSessionProvider?.isLoggedIn else { return false }
        return isLoggedIn
    }
}
