//
//  UserSessionMock.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//

import Foundation

final class UserSessionMock: UserSessionProtocol {
    
    var storedUserCredential: UserCredential?
    
    var userCredential: UserCredential? {
        get { storedUserCredential }
        set { storedUserCredential = newValue }
    }
}
