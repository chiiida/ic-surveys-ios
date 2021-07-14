//
//  SplashInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/23/21.
//  
//

import Foundation

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
        guard ProcessInfo.processInfo.environment[TestConstants.userLoggedInKey] == nil else { return true }
        return userSessionProvider?.isLoggedIn ?? false
    }
}
