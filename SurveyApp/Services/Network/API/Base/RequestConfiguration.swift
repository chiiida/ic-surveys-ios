//
//  RequestConfiguration.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

import Alamofire

final class RequestConfiguration {

    let method: HTTPMethod
    let url: URLConvertible
    let headers: HTTPHeaders?
    let parameters: Parameters?
    let parameterEncoding: ParameterEncoding

    init(
        method: HTTPMethod,
        url: URLConvertible,
        headers: [String: String]? = nil,
        parameters: Parameters? = nil,
        parameterEncoding: ParameterEncoding = JSONEncoding.default
    ) {
        self.method = method
        self.url = url
        self.headers = HTTPHeaders(headers ?? [:])
        self.parameters = parameters
        self.parameterEncoding = parameterEncoding
    }
}
