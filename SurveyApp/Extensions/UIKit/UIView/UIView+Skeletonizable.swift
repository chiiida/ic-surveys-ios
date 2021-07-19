//
//  UIView+Skeletonizable.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/13/21.
//

import SkeletonView

extension UIView {
    
    func skeletonize() {
        let gradient = SkeletonGradient(baseColor: .darkGray, secondaryColor: .systemGray)
        showAnimatedGradientSkeleton(usingGradient: gradient)
    }
}
