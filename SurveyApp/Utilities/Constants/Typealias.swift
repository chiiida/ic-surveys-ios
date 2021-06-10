//
//  Typealias.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/9/21.
//

import Alamofire

typealias Parameters = [String: Any]
typealias RequestResult<T> = (Result<T, Error>)
typealias RequestCompletion<T> = (RequestResult<T>) -> Void
