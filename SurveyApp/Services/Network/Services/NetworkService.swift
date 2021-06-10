//
//  NetworkService.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/9/21.
//

import Foundation

class NetworkService {
    
    let api: API
    let baseURL: String
    
    init(api: API, baseURL: String) {
        self.api = api
        self.baseURL = baseURL
    }
    
    func url(forEndpoint endpoint: String) -> String {
        api.url(forEndpoint: endpoint, baseURL: baseURL)
    }
}
