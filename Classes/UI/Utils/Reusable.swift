//
//  Reusable.swift
//
//  Created by Igors Nemenonoks on 17/11/16.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

public extension Reusable {
    static var reuseIdentifier: String { return String(describing: Self.self) }
    static var nib: UINib? { return nil }
}

extension UICollectionView {
    public func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

public extension String {
    static func className(_ obj: AnyObject) -> String {
        return String(describing:obj.self).components(separatedBy: ".").last!
    }

    static func className(_ cls: AnyClass) -> String {
        return String(describing:cls).components(separatedBy: ".").last!
    }
}

extension UIView {
    public static func viewFromXib<T: UIView>(_ aBundle: Bundle? = nil) -> T {
        return UINib(nibName: String.className(T.self), bundle: aBundle).instantiate(withOwner: nil, options: nil)[0] as! T
    }
}
