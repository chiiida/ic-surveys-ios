//
//  DateFormatter+Format.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/21/21.
//

import Foundation

extension DateFormatter {

    static let date = DateFormatter(with: "EEEE, MMMM d")

    private convenience init(with format: String) {
        self.init()
        dateFormat = format
    }
}
