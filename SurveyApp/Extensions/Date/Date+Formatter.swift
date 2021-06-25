//
//  Date+Formatter.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/21/21.
//

import Foundation

extension Date {

    func formatted(with formatter: DateFormatter) -> String {
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter.string(from: self)
    }
}
