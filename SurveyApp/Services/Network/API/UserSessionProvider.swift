//
//  UserSessionProvider.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/16/21.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol UserSessionProviderProtocol: AnyObject {

    var userSession: UserSessionProtocol? { get }
    var isLoggedIn: Bool { get }
    
    func logout()
}

final class UserSessionProvider: UserSessionProviderProtocol {

    public static let shared = UserSessionProvider()

    var userSession: UserSessionProtocol?

    public var isLoggedIn: Bool {
        userSession?.userCredential?.refreshToken != nil
    }

    public func clearCredentials() {
        userSession?.userCredential = nil
    }
    
    func logout() {
        clearCredentials()
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        
        let module = LoginModule()
        let navigationController = UINavigationController(rootViewController: module.view)
        sceneDelegate.window?.rootViewController = navigationController
    }
}
