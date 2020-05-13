//
//  DestinationVC.swift
//  DesignSystemExample
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxFlow
import MXParallaxHeader

final class DestinationVC: Screen {

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        addHeader()
    }

    private func addHeader() {
        let headerView: HeaderDestination = HeaderDestination.viewFromXib()

        collectionView.parallaxHeader.view = headerView
        collectionView.parallaxHeader.height = HeaderDestination.height
        collectionView.parallaxHeader.minimumHeight = HeaderDestination.minimumHeight
        collectionView.parallaxHeader.mode = .fill

        headerView.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true

        headerView.backButton.rx.tap
            .map({ FlowStep.Explore.pop })
            .bind(to: self.viewModel.steps)
            .disposed(by: bag)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
