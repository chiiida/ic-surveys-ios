//
//  UserDefaultsKey.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//

protocol UserDefaultsKeys {}

final class UserDefaultsKey<T>: UserDefaultsKeys {
    
    let key: String
    
    init(_ key: String) {
        self.key = key
    }
}
