//
//  BaseAPI.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

import Foundation
import Alamofire

final class BaseAPI: API {
    
    private let userSession: UserSessionProtocol

    init(userSession: UserSessionProtocol) {
        self.userSession = userSession
    }
    
    func url(forEndpoint endpoint: String, baseURL: String) -> String {
        let url = URL(string: baseURL)?.appendingPathComponent(endpoint, isDirectory: false)
        return url?.absoluteString ?? baseURL
    }
    
    func performRequest<T: Decodable>(
        with configuration: RequestConfiguration,
        completion: @escaping RequestCompletion<T>
    ) -> Request {
        AF.request(
            configuration.url,
            method: configuration.method,
            parameters: configuration.parameters,
            encoding: configuration.parameterEncoding,
            headers: configuration.headers,
            interceptor: AuthenticationInterceptor(userSession: userSession)
        )
        .validate()
        .responseDecodable { (response: Result<T, APIError>) in
            switch response {
            case .success(let decoded):
                completion(.success(decoded))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
