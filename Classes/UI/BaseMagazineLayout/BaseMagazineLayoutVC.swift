//
//  BaseMagazineLayoutVC.swift
//  Chili Labs
//
//  Created by Igors Nemenonoks on 11/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import UIKit
import MagazineLayout
import RxSwift
import RxCocoa
import SnapKit

protocol PBaseMagazineLayoutVC: UICollectionViewDelegateMagazineLayout, UICollectionViewDataSource {
    var sections: Binder<[MagazineLayoutSection]> { get }
    var collectionView: UICollectionView { get }
    func didSelectItem<DataType: MagazineCellDataType, CellType: ConfigurableCell>() -> Observable<MagazineCellConfigurator<DataType, CellType>>
}

class BaseMagazineLayoutVC: UIViewController, PBaseMagazineLayoutVC {

    var sections: Binder<[MagazineLayoutSection]> {
        return Binder(self) { vc, items in
            vc._sections.accept(items)
        }
    }

    fileprivate let _sections = BehaviorRelay(value: [MagazineLayoutSection]())

    //published when cell got selected
    private let selectPublisher = PublishRelay<CellConfigurator>()
    private lazy var cellsRegistrator = CollectionViewCellsRegistrator(collectionView: self.collectionView)

    private let bag = DisposeBag()

    // Collection view
    lazy var collectionView: UICollectionView = {
        let layout = MagazineLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .always
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.insertSubview(self.collectionView, at: 0)

        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.snp.makeConstraints { $0.edges.equalTo(0) }

        self._sections.subscribe(onNext: { [weak self] sections in
            self?.cellsRegistrator.registerCells(for: sections)
        }).disposed(by: bag)
    }

    func didSelectItem<DataType: MagazineCellDataType, CellType: ConfigurableCell>() -> Observable<MagazineCellConfigurator<DataType, CellType>> {
        return self.selectPublisher
            .filter({ (configurator) -> Bool in
                return configurator is MagazineCellConfigurator<DataType, CellType>
            })
            .map { configurator -> MagazineCellConfigurator<DataType, CellType> in
                return configurator as! MagazineCellConfigurator<DataType, CellType>
            }
    }
}

extension BaseMagazineLayoutVC: UICollectionViewDelegateMagazineLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeModeForItemAt indexPath: IndexPath) -> MagazineLayoutItemSizeMode {
        return self._sections.value[indexPath.section].items[indexPath.row].sizeMode
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForHeaderInSectionAtIndex index: Int) -> MagazineLayoutHeaderVisibilityMode {
        return self._sections.value[index].header.visibilityMode
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForFooterInSectionAtIndex index: Int) -> MagazineLayoutFooterVisibilityMode {
        return self._sections.value[index].footer.visibilityMode
    }
    // swiftlint:disable line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
        return self._sections.value[index].background.visibilityMode
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, horizontalSpacingForItemsInSectionAtIndex index: Int) -> CGFloat {
        return self._sections.value[index].itemsInset.right
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, verticalSpacingForElementsInSectionAtIndex index: Int) -> CGFloat {
        return self._sections.value[index].itemsInset.bottom
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetsForSectionAtIndex index: Int) -> UIEdgeInsets {
        return self._sections.value[index].sectionInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetsForItemsInSectionAtIndex index: Int) -> UIEdgeInsets {
        return self._sections.value[index].itemsInset
    }
}
extension BaseMagazineLayoutVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self._sections.value.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._sections.value[section].items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellConfigurator = self._sections.value[indexPath.section].items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: cellConfigurator).cellReuseIdentifier, for: indexPath)
        cellConfigurator.configure(cell: cell)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let section = _sections.value[indexPath.section]
        if let sectionItem = section.header.item, kind == MagazineLayout.SupplementaryViewKind.sectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: MagazineLayout.SupplementaryViewKind.sectionHeader,
                                                                       withReuseIdentifier: type(of: sectionItem).cellReuseIdentifier,
                                                                       for: indexPath)
            sectionItem.configure(cell: cell)
            return cell
        } else if let sectionItem = section.footer.item, kind == MagazineLayout.SupplementaryViewKind.sectionFooter {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: MagazineLayout.SupplementaryViewKind.sectionFooter,
                                                                       withReuseIdentifier: type(of: sectionItem).cellReuseIdentifier,
                                                                       for: indexPath)
            sectionItem.configure(cell: cell)
            return cell
        }

        fatalError("Not supported")
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectPublisher.accept(self._sections.value[indexPath.section].items[indexPath.row])
        self._sections.value[indexPath.section].items[indexPath.row].didSelect()
    }
}
