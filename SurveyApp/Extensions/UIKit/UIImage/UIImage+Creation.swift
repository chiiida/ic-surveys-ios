//
//  UIImage+Creation.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/7/21.
//

import UIKit

extension UIImage {

    static func withBackground(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { ctx in
            color.setFill()
            ctx.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
    }
}
