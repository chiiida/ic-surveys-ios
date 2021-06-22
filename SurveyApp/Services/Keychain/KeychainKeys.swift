//
//  KeychainKeys.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/16/21.
//

protocol KeychainKeys {}

extension KeychainKeys {

    static var credential: KeychainStorage.Key<UserCredential> {
        KeychainStorage.Key(key: "userCredential")
    }
}
