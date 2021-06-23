//
//  UIImage+URL.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/21/21.
//

import UIKit

extension UIImageView {

    func loadUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
