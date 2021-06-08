//
//  UITextField+Placeholder.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/8/21.
//

import UIKit

extension UITextField {
    
    func setPlaceholderColor(color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
