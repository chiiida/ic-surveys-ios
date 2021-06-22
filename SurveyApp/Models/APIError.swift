//
//  APIError.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
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
    
    init(detail: String = "") {
        let errorDetail = ErrorDetail(source: nil, detail: detail, code: nil)
        self.errors = [errorDetail]
    }
}
