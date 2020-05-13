//
//  MagazineLayoutSection.swift
//  Spendo
//
//  Created by Igors Nemenonoks on 14/05/2019.
//  Copyright © 2019 Chili Labs. All rights reserved.
//

import Foundation
import MagazineLayout

struct MagazineLayoutSection {

    struct HeaderInfo {
        let item: SupplementaryCellConfigurator?
        let visibilityMode: MagazineLayoutHeaderVisibilityMode

        static func hidden() -> HeaderInfo {
            return .init(item: nil, visibilityMode: .hidden)
        }
    }

    struct FooterInfo {
        let item: SupplementaryCellConfigurator?
        let visibilityMode: MagazineLayoutFooterVisibilityMode

        static func hidden() -> FooterInfo {
            return .init(item: nil, visibilityMode: .hidden)
        }
    }

    struct BackgroundInfo {
        let visibilityMode: MagazineLayoutBackgroundVisibilityMode

        static func hidden() -> BackgroundInfo {
            return .init(visibilityMode: .hidden)
        }
    }

    let header: HeaderInfo
    let footer: FooterInfo
    let items: [CellConfigurator]
    let background: BackgroundInfo
    let sectionInset: UIEdgeInsets
    let itemsInset: UIEdgeInsets

    init(items: [CellConfigurator],
         header: HeaderInfo = .hidden(),
         footer: FooterInfo = .hidden(),
         background: BackgroundInfo = .hidden(),
         sectionInset: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16),
         itemsInset: UIEdgeInsets = UIEdgeInsets.zero) {
        self.header = header
        self.footer = footer
        self.items = items
        self.background = background
        self.sectionInset = sectionInset
        self.itemsInset = itemsInset
    }
}
