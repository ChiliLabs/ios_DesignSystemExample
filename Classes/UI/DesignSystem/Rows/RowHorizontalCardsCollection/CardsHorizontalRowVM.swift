//
//  RowHorizontalCardsCollectionVM.swift
//  Chili Labs
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import MagazineLayout
import RxFlow
import RxSwift
import RxCocoa

final class RowHorizontalCardsCollectionVM: MagazineCellDataType, Stepper {
    let steps = PublishRelay<Step>()

    lazy private(set) var sizeMode = MagazineLayoutItemSizeMode(widthMode: .fullWidth(respectsHorizontalInsets: true),
                                                                heightMode: .static(height: self.itemHeight))

    let items: [MagazineCellDataType]

    private let bag = DisposeBag()

    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let itemsSpacing: CGFloat

    var configurators: [CellConfigurator] {
        return items.map({ $0.configurator()})
    }

    init(items: [MagazineCellDataType], itemWidth: CGFloat, itemHeight: CGFloat, itemsSpacing: CGFloat = 16) {
        self.items = items
        self.itemWidth = itemWidth
        self.itemHeight = itemHeight
        self.itemsSpacing = itemsSpacing
        self.items.forEach { [unowned self] vm in
            (vm as? Stepper)?.steps.bind(to: self.steps).disposed(by: self.bag)
        }
    }

    var diffHash: Int {
        return items.map({ $0.diffHash }).reduce(0, ^)
    }

    func didSelect() {
        //do nothing as this cell is just a container
    }

    func configurator() -> CellConfigurator {
        return RowHorizontalCardsCollectionConfigurator(item: self)
    }
}
