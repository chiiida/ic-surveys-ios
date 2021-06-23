//
//  AnimatedCollectionView.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/22/21.
//

import UIKit

enum AnimationStyle {
    
    case fade
}

final class AnimatedCollectionViewLayout: UICollectionViewFlowLayout {
    
    let animationStyle: AnimationStyle
    private var distance: CGFloat
    private var itemOffset: CGFloat
    
    init(animationStyle: AnimationStyle) {
        self.animationStyle = animationStyle
        self.distance = 0.0
        self.itemOffset = 0.0
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?
            .compactMap { $0.copy() as? UICollectionViewLayoutAttributes }
            .compactMap(prepareAttributes)
    }
    
    private func prepareAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        switch scrollDirection {
        case .horizontal:
            distance = collectionView.frame.width
            itemOffset = attributes.center.x - collectionView.contentOffset.x
        case .vertical:
            distance = collectionView.frame.height
            itemOffset = attributes.center.y - collectionView.contentOffset.y
        @unknown default:
            distance = 0.0
            itemOffset = 0.0
        }
        
        return prepareAnimation(attributes)
    }
    
    private func prepareAnimation(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        switch animationStyle {
        case .fade:
            let contentOffset = collectionView.contentOffset
            attributes.frame = CGRect(origin: contentOffset, size: attributes.frame.size)
            attributes.alpha = 1 - abs(itemOffset / distance - 0.5)
        }
        
        return attributes
    }
}
