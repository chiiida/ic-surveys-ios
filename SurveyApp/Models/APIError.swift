//
//  APIError.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/10/21.
//

import Alamofire

struct ErrorDetail: Decodable, Error {
    
    enum CodingKeys: String, CodingKey {
        case source, detail, code
    }
    
    let source: String?
    let detail: String?
    let code: String?
}

struct APIError: Decodable, Error {
    
    enum CodingKeys: String, CodingKey {
        case errors
    }
    
    let errors: [ErrorDetail]?
}
