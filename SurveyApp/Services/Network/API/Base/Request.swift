//
//  Request.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/9/21.
//

import Alamofire

public protocol Request: AnyObject {

    @discardableResult
    func cancel() -> Self
}

extension Alamofire.Request: Request {
}
