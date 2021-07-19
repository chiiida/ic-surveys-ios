//
//  SeededAPI.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/2/21.
//

import Foundation
import Alamofire

class SeededAPI: API {
    
    var userSession: UserSessionProtocol
    var subtitutedAPI: API

    init(
        userSession: UserSessionProtocol,
        api: API
    ) {
        self.userSession = userSession
        self.subtitutedAPI = api
    }

    func url(forEndpoint endpoint: String, baseURL: String) -> String {
        let url = URL(string: baseURL)?.appendingPathComponent(endpoint, isDirectory: false)
        return url?.absoluteString ?? baseURL
    }

    func performRequest<T>(with configuration: RequestConfiguration, completion: @escaping RequestCompletion<T>) -> Request where T: Decodable {
        guard let url = try? configuration.url.asURL() else {
            return subtitutedAPI.performRequest(with: configuration, completion: completion)
        }

        let environment: [String: String] = ProcessInfo.processInfo.environment
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()

        // Success
        let successKey = MockAPIKey(
            method: configuration.method,
            endPoint: url.path,
            status: true
        ).rawValue

        if let response = environment[successKey],
           let data = response.data(using: .utf8),
           let object = try? decoder.decode(T.self, from: data) {
            completion(.success(object))
            return AF.request("")
        }
        
        if let response = environment[successKey],
           let data = response.data(using: .utf8),
           data == " ".data(using: .utf8) {
            // swiftlint:disable force_cast
            completion(.success(EmptyResponse() as! T))
            return AF.request("")
        }

        // Failure
        let failureKey = MockAPIKey(
            method: configuration.method,
            endPoint: url.path,
            status: false
        ).rawValue
        
        if let response = environment[failureKey],
           let data = response.data(using: .utf8),
           let error = try? JSONDecoder().decode(APIError.self, from: data) {
            completion(.failure(error))
            return AF.request("")
        }

        return subtitutedAPI.performRequest(
            with: configuration,
            completion: completion
        )
    }
}
