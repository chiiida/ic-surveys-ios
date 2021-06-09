//
//  UITextField+Placeholder.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/8/21.
//

import UIKit
import Foundation

extension UITextField {
    
    var placeholderColor: UIColor {
        get {
            let attributes = attributedPlaceholder?.attributes(at: 0, effectiveRange: nil)
            return attributes?[NSAttributedString.Key.foregroundColor] as? UIColor ?? UIColor.lightGray
        }
        set(newColor) {
            attributedPlaceholder = NSAttributedString(
                string: placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: newColor]
            )
        }
    }
}
