//
//  JSON+APIError.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 6/17/21.
//

import Foundation

extension JSON.APIError {
    
    static var sampleAPIError: Data {
        """
        {
            "errors": [
                {
                    "source": "Sample source",
                    "detail": "Sample API error detail",
                    "code": "sample_code"
                }
            ]
        }
        """.data(using: .utf8)!
    }
}
