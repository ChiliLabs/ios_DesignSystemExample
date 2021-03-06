//
//  RowDestinationTitle.swift
//  Chili Labs
//
//  Generated by Chigevara on 14/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import UIKit
import MagazineLayout
import RxSwift

typealias RowDestinationTitleConfigurator = MagazineCellConfigurator<RowDestinationTitleVM, RowDestinationTitle>
final class RowDestinationTitle: MagazineLayoutCollectionViewCell, ConfigurableCell {

    static var nib: UINib? { return UINib(nibName: self.reuseIdentifier, bundle: nil) }

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    private var bag = DisposeBag()

    func configure(item: RowDestinationTitleVM) {
        self.textLabel.styledText = item.title

        likeButton.rx.tap.scan(false) { lastState, newValue in
            return !lastState
        }
        .bind(to: self.likeButton.rx.isSelected)
        .disposed(by: bag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.bag = DisposeBag()
    }
}
