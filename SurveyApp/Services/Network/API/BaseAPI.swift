//
//  BaseAPI.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/9/21.
//

import Foundation
import Alamofire

final class BaseAPI: API {
    
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
            headers: configuration.headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decoded):
                completion(.success(decoded))
            case .failure(_):
                do {
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(APIError.self, from: response.data ?? Data())
                    completion(.failure(apiError))
                } catch {
                    let errorResponse = String(data: response.data ?? Data(), encoding: .utf8)
                    completion(.failure(APIError(detail: "error decoding \(errorResponse ?? "API error response")")))
                }
            }
        }
    }
}
