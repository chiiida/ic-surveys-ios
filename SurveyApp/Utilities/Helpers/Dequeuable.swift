//
//  Dequeuable.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/21/21.
//

import UIKit

protocol Dequeuable: AnyObject {
    
    static var reuseIdentifier: String { get }
}

extension UICollectionReusableView: Dequeuable {
    
    static var reuseIdentifier: String { "\(Self.self)" }
}

extension UICollectionView {
    
    func register(_ cellType: Dequeuable.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueReusable<Cell: Dequeuable>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        // swiftlint:disable force_cast
        return dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }
}
