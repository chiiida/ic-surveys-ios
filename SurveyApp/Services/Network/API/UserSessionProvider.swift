//
//  UserSessionProvider.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/16/21.
//

import Foundation

// sourcery: AutoMockable
protocol UserSessionProviderProtocol: AnyObject {

    var userSession: UserSession? { get }
    var isLoggedIn: Bool { get }
}

final class UserSessionProvider: UserSessionProviderProtocol {

    public static let shared = UserSessionProvider()

    var userSession: UserSession?

    public var isLoggedIn: Bool {
        userSession?.userCredential?.refreshToken != nil
    }

    public func clearCredentials() {
        userSession?.userCredential = nil
    }
}
