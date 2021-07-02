//
//  XCUIElement.swift
//  SurveyAppUITests
//
//  Created by Chananchida F. on 7/2/21.
//

import XCTest

extension XCUIElement {
    
    func tapThen() -> Self {
        tap()
        return self
    }
}
