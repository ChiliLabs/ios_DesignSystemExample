//
//  CellConfigurators.swift
//  Spendo
//
//  Created by Igors Nemenonoks on 15/05/2019.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import UIKit
import MagazineLayout

//Cell configurators

protocol Diffable {
    var diffHash: Int { get }
}

protocol CellSizable: GenericCell {
    var sizeMode: MagazineLayoutItemSizeMode { get }
}

//means that cell can be selected
protocol SelectableData {
    func didSelect()
}

protocol GenericCell { }

protocol CellConfigurator: CellSizable, Diffable, SelectableData {
    static var cellType: GenericCell.Type { get }
    static var cellReuseIdentifier: String { get }

    func configure(cell: UIView)
    func didSelect()
}

protocol ConfigurableCell: GenericCell, Reusable {
    associatedtype DataType
    func configure(item: DataType)
}

//defines that object should return its configurator
protocol CellConfigurable {
    func configurator() -> CellConfigurator
}

typealias MagazineCellDataType = Diffable & CellSizable & SelectableData & CellConfigurable

final class MagazineCellConfigurator<DataType: MagazineCellDataType, CellType: ConfigurableCell>: CellConfigurator where CellType.DataType == DataType, CellType: UIView {

    let item: DataType

    init(item: DataType) {
        self.item = item
    }

    func configure(cell: UIView) {
        (cell as? CellType)?.configure(item: item)
    }

    func didSelect() {
        item.didSelect()
    }

    static var cellReuseIdentifier: String {
        return CellType.reuseIdentifier
    }

    static var cellType: GenericCell.Type {
        return CellType.self
    }

    var sizeMode: MagazineLayoutItemSizeMode {
        return item.sizeMode
    }

    var diffHash: Int {
        return String(describing: DataType.self).hashValue ^ self.item.diffHash
    }
}

//Reusable cells like headers or footers
protocol SupplementaryCellSizable: GenericCell {
    var heightMode: MagazineLayoutHeaderHeightMode { get }
}

protocol SupplementaryCellConfigurator: SupplementaryCellSizable, Diffable {
    static var cellType: GenericCell.Type { get }
    static var cellReuseIdentifier: String { get }

    func configure(cell: UIView)
}

protocol SupplementaryConfigurable {
    func configurator() -> SupplementaryCellConfigurator
}

typealias MagazineSupplementaryDataType = Diffable & SupplementaryCellSizable & SupplementaryConfigurable

final class MagazineSupplementaryCellConfigurator<DataType: MagazineSupplementaryDataType, CellType: ConfigurableCell>: SupplementaryCellConfigurator where CellType.DataType == DataType, CellType: UIView {

    let item: DataType

    init(item: DataType) {
        self.item = item
    }

    func configure(cell: UIView) {
        (cell as? CellType)?.configure(item: item)
    }

    static var cellReuseIdentifier: String {
        return CellType.reuseIdentifier
    }

    static var cellType: GenericCell.Type {
        return CellType.self
    }

    var heightMode: MagazineLayoutHeaderHeightMode {
        return item.heightMode
    }

    var diffHash: Int {
        return String(describing: DataType.self).hashValue ^ self.item.diffHash
    }
}
