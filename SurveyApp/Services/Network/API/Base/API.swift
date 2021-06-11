//
//  API.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

import Foundation

protocol API {
    
    func url(forEndpoint endpoint: String, baseURL: String) -> String
    func performRequest<T: Decodable>(
        with configuration: RequestConfiguration,
        completion: @escaping RequestCompletion<T>
    ) -> Request
}
