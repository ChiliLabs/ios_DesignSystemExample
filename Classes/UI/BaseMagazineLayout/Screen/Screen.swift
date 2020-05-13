//
//  Screen.swift
//  Spendo
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

protocol SectionedViewModel: Stepper {
    var sections: Observable<[MagazineLayoutSection]> { get }
}

class Screen: BaseMagazineLayoutVC {
    let viewModel: SectionedViewModel
    private let bag = DisposeBag()

    init(viewModel: SectionedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.sections.bind(to: self.sections).disposed(by: bag)
    }
}
