//
//  Array+Comparable.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//

import Foundation

extension Array where Element: Comparable {
    
    func isEqual(to other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}
