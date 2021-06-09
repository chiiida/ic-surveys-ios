//
//  TextFieldWithPadding.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/9/21.
//

import UIKit

final class CredentialTextField: UITextField {
    
    var textPadding = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override var placeholder: String? {
        didSet {
            let placeholderColor = UIColor.white.withAlphaComponent(0.3)
            attributedPlaceholder = NSAttributedString(
                string: placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
            )
        }
    }
    
    private func commonInit() {
        layer.cornerRadius = 12.0
        backgroundColor = UIColor.white.withAlphaComponent(0.18)
        
        textColor = .white
        font = .regular(ofSize: .body)
    }
}
