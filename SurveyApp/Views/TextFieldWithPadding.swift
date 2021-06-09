//
//  TextFieldWithPadding.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/9/21.
//

import UIKit

final class TextFieldWithPadding: UITextField {
    
    var textPadding = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
