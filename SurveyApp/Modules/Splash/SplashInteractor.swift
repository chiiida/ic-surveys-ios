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
        if ProcessInfo.processInfo.environment[TestConstants.userLoggedInKey] != nil {
            return false
        } else {
            return userSessionProvider?.isLoggedIn ?? false
        }
    }
}
