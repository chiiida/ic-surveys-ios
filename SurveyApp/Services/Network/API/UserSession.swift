//
//  UserSession.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/16/21.
//

import Foundation

protocol UserSessionProtocol: AnyObject {

    var userCredential: UserCredential? { get set }
}

final class UserSession: UserSessionProtocol {

    private let keychain: KeychainStorageProtocol

    var userCredential: UserCredential? {
        get { try? keychain.get(.credential) }
        set { try? keychain.set(newValue, for: .credential) }
    }

    init(keychain: KeychainStorageProtocol) {
        self.keychain = keychain
    }
}
