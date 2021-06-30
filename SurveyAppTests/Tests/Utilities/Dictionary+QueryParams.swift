//
//  Dictionary+QueryParams.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 6/28/21.
//

extension Dictionary where Key == String {
    
    func toQueryParams() -> [String: String?] {
        var dict: [String: String] = [:]
        self.forEach { key, value in dict[key] = "\(value)" }
        return dict
    }
}
