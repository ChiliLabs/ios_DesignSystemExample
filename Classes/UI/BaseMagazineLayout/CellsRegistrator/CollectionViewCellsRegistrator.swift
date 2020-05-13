//
//  CollectionViewCellsRegistrator.swift
//  Spendo
//
//  Created by Igors Nemenonoks on 17/05/2019.
//  Copyright © 2019 Chili Labs. All rights reserved.
//

import Foundation
import UIKit
import MagazineLayout

final class CollectionViewCellsRegistrator {

    private(set) weak var collectionView: UICollectionView?
    private var registeredIdentifiers = Set<String>()

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    func registerCells(for sections: [MagazineLayoutSection]) {
        sections.forEach({ (section) in
            if let headerItem = section.header.item,
                registeredIdentifiers.contains(type(of: headerItem).cellReuseIdentifier) == false,
                let headerType = type(of: headerItem).cellType as? (UICollectionReusableView & Reusable).Type {

                self.registerReusableCell(type: headerType)
            }
            self.register(cellConfigs: section.items)
        })
    }

    func register(cellConfigs: [CellConfigurator]) {
        cellConfigs.forEach({ (conf) in
            if let cellType = type(of: conf).cellType as? (UICollectionViewCell & Reusable).Type,
                registeredIdentifiers.contains(cellType.reuseIdentifier) == false {
                self.registerCell(type: cellType)
            }
        })
    }

    private func registerReusableCell(type aType: (UICollectionReusableView & Reusable).Type) {
        if let nib = aType.nib {
            self.collectionView?.register(nib,
                                          forSupplementaryViewOfKind: MagazineLayout.SupplementaryViewKind.sectionHeader,
                                          withReuseIdentifier: aType.reuseIdentifier)
        } else {
            self.collectionView?.register(aType.self,
                                          forSupplementaryViewOfKind: MagazineLayout.SupplementaryViewKind.sectionHeader,
                                          withReuseIdentifier: aType.reuseIdentifier)
        }
        self.registeredIdentifiers.insert(aType.reuseIdentifier)
    }

    private func registerCell(type aType: (UICollectionViewCell & Reusable).Type) {
        if let nib = aType.nib {
            self.collectionView?.register(nib, forCellWithReuseIdentifier: aType.reuseIdentifier)
        } else {
            self.collectionView?.register(aType.self, forCellWithReuseIdentifier: aType.reuseIdentifier)
        }
        registeredIdentifiers.insert(aType.reuseIdentifier)
    }
}
