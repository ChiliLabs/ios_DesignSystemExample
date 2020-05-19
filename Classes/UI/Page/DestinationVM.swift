//
//  DestinationVM.swift
//  DesignSystemExample
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

final class DestinationVM: SectionedViewModel {

    @VMProperty([]) var sections: Observable<[MagazineLayoutSection]>

    let steps = PublishRelay<Step>()
    private let bag = DisposeBag()

    init() {
        let header1 = HeaderHeadline2VM(title: "Introduction")
        let header2 = HeaderHeadline2VM(title: "Places to see")

        $sections.accept([
            MagazineLayoutSection(items: [
                RowDestinationTitleVM(title: "Indonesia, Bali").configurator()
            ], sectionInset: UIEdgeInsets(top: 0, left: 32, bottom: 16, right: 16)),
            MagazineLayoutSection(items: [
                RowTextVM(text: "Bali is an Indonesian island known for its forested volcanic mountains, iconic rice paddies, white beaches and coral reefs. The island is home to religious sites such as cliffside Uluwatu Temple. The island is also known for its yoga and meditation retreats.").configurator()
            ], header: .init(item: header1.configurator(),
                             visibilityMode: .visible(heightMode: header1.heightMode, pinToVisibleBounds: false)),
               sectionInset: UIEdgeInsets(top: 0, left: 32, bottom: 16, right: 16)),
            MagazineLayoutSection(items: [
                RowHorizontalCardsCollectionVM(items: [
                    CardPhotoThumbnailVM(url: "https://upload.wikimedia.org/wikipedia/commons/5/5e/Uluwatu%40bali.jpg"),
                    CardPhotoThumbnailVM(url: "https://p1.pxfuel.com/preview/458/393/320/bali-tour-packages-book-bali-honeymoon-packages-bali-holiday-packages-best-travel-agency-in-delhi.jpg"),
                    CardPhotoThumbnailVM(url: "https://cdn.pixabay.com/photo/2017/06/07/05/10/ubud-bali-2379365_960_720.jpg"),
                    CardPhotoThumbnailVM(url: "https://dimg04.c-ctrip.com/images/200t0x000000kx593CDF5_R_550_412_R5_Q70_D.jpg")
                    ],
                                               itemWidth: 164,
                                               itemHeight: 120,
                                               itemsSpacing: 8).configurator()
            ], header: .init(item: header2.configurator(),
                             visibilityMode: .visible(heightMode: header1.heightMode, pinToVisibleBounds: false)),
               sectionInset: UIEdgeInsets(top: 16, left: 32, bottom: 32, right: 16),
               itemsInset: UIEdgeInsets(top: 8, left: -32, bottom: 0, right: -16))
        ])
    }
}
