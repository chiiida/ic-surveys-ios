//
//  APIError.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

import Alamofire

protocol ErrorSourceType {}

struct ErrorSourceParameter: Decodable, Error {
    
    enum CodingKeys: String, CodingKey {
        case parameter
    }
    
    let parameter: String?
}

struct ErrorDetail: Decodable, Error {
    
    enum CodingKeys: String, CodingKey {
        case source, detail, code
    }
    
    var source: ErrorSourceType?
    let detail: String?
    let code: String?
    
    var codeErrorType: CodeErrorType {
        guard let errorType = CodeErrorType(rawValue: code ?? "") else { return .undefined }
        return errorType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        detail = try? container.decode(String.self, forKey: .detail)
        code = try? container.decode(String.self, forKey: .code)
        
        switch codeErrorType {
        case .invalidToken:
            source = try? container.decode(ErrorSourceParameter.self, forKey: .source)
        default:
            source = try? container.decode(String.self, forKey: .source)
        }
    }
    
    init(detail: String) {
        self.source = nil
        self.detail = detail
        self.code = nil
    }
}

struct APIError: Decodable, Error {
    
    enum CodingKeys: String, CodingKey {
        case errors
    }
    
    let errors: [ErrorDetail]?
    
    init(detail: String = "") {
        let errorDetail = ErrorDetail(detail: detail)
        self.errors = [errorDetail]
    }
}

extension ErrorDetail {
    
    enum CodeErrorType: String {
        case invalidClient = "invalid_client"
        case invalidGrant = "invalid_grant"
        case invalidToken = "invalid_token"
        
        case undefined
    }
}

extension String: ErrorSourceType {}

extension ErrorSourceParameter: ErrorSourceType {}
