//
//  ExploreVM.swift
//  DesignSystemExample
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

final class ExploreVM: SectionedViewModel {

    @VMProperty([]) var sections: Observable<[MagazineLayoutSection]>

    let steps = PublishRelay<Step>()
    private let bag = DisposeBag()

    init() {

        let destinations = [
            CardDestinationVM(imageUrl: "http://chililabs.io/images/opensource/ios_design_system/img_1.jpg",
                              title: "Maldives",
                              subtitle: "34 people visited",
                              step: FlowStep.Explore.page),
            CardDestinationVM(imageUrl: "http://chililabs.io/images/opensource/ios_design_system/img_2.jpg",
                              title: "Egypt",
                              subtitle: "129 people visited",
                              step: FlowStep.Explore.page),
            CardDestinationVM(imageUrl: "http://chililabs.io/images/opensource/ios_design_system/img_3.jpg",
                              title: "Bali",
                              subtitle: "87 people visited",
                              step: FlowStep.Explore.page)
        ]

        let header = HeaderSectionTitleVM(title: "Last visited", subtitle: "Your last visited destinations")

        $sections.accept(
            [
                MagazineLayoutSection(items: [
                    RowHeadline1VM(title: "Explore new places and meet new people").configurator(),
                    RowCaptionVM(title: "Most popular destinations").configurator()
                ], sectionInset: UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 16)),
                MagazineLayoutSection(items: [
                    RowHorizontalCardsCollectionVM(items: destinations,
                                                   itemWidth: 136,
                                                   itemHeight: 224,
                                                   itemsSpacing: 8).configurator()
                    ], sectionInset: UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)),
                MagazineLayoutSection(items: [
                    RowFlightInfoVM(info: FlightInfo(departureTime: "05:00",
                                                     departureAirport: "Riga (RIX)",
                                                     arrivalTime: "20:00",
                                                     arrivalAirport: "Tokyo (HND)")).configurator(),
                    RowFlightInfoVM(info: FlightInfo(departureTime: "14:00",
                                                     departureAirport: "Riga (RIX)",
                                                     arrivalTime: "23:30",
                                                     arrivalAirport: "Bali (DPS)")).configurator(),

                    RowFlightInfoVM(info: FlightInfo(departureTime: "07:30",
                                                     departureAirport: "Riga (RIX)",
                                                     arrivalTime: "12:15",
                                                     arrivalAirport: "Cyprus (LCA)")).configurator()
                    ],
                                      header: .init(item: header.configurator(), visibilityMode: .visible(heightMode: header.heightMode)),
                                      sectionInset: UIEdgeInsets(top: 24, left: 32, bottom: 32, right: 16))

            ]
        )

        destinations.forEach {
            $0.steps.bind(to: self.steps).disposed(by: bag)
        }
    }
}
