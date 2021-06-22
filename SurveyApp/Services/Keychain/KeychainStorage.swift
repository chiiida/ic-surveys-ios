//
//  KeychainStorage.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/16/21.
//

import KeychainAccess

protocol KeychainStorageProtocol: AnyObject {

    func get<T: Decodable>(_ key: KeychainStorage.Key<T>) throws -> T?
    func set<T: Encodable>(_ value: T?, for key: KeychainStorage.Key<T>) throws

    func remove<T>(_ key: KeychainStorage.Key<T>) throws
}

final class KeychainStorage: KeychainStorageProtocol {

    struct Key<T>: KeychainKeys {

        let key: String
    }

    static let `default` = KeychainStorage(service: Bundle.main.bundleIdentifier ?? "")

    private let keychain: Keychain

    private init(service: String) {
        keychain = Keychain(service: service)
    }

    func set<T: Encodable>(_ value: T?, for key: Key<T>) throws {
        guard let value = value else { return try remove(key) }
        try keychain.set(JSONEncoder().encode(value), key: key.key)
    }

    func get<T: Decodable>(_ key: Key<T>) throws -> T? {
        try keychain
            .getData(key.key)
            .map { try JSONDecoder().decode(T.self, from: $0) }
    }

    func remove<T>(_ key: KeychainStorage.Key<T>) throws {
        try keychain.remove(key.key)
    }
}
