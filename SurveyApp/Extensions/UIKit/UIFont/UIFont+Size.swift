//
//  UIFont+Size.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/8/21.
//

import UIKit

extension UIFont {
    
    enum FontSize: CGFloat {
        /// size = 46
        case largerTitle = 34.0
        /// size = 28
        case title = 28.0
        /// size = 24
        case lead = 24.0
        /// size = 18
        case heading = 18.0
        /// size = 16
        case body = 16.0
        /// size = 12
        case small = 14.0
    }
    
    static func regular(ofSize size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue)
    }
    
    static func bold(ofSize size: FontSize) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size.rawValue)
    }
}
