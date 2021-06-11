//
//  Typealias.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

import Alamofire

typealias Parameters = [String: Any]
typealias RequestResult<T> = (Result<T, APIError>)
typealias RequestCompletion<T> = (RequestResult<T>) -> Void
