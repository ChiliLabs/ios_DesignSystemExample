//
//  Typography.swift
//  DesignSystemExample
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import BonMot

enum Typography {
    static let Headline1 = StringStyle(
        .font(UIFont.systemFont(ofSize: 32, weight: .medium))
    )

    static let Headline2 = StringStyle(
        .font(UIFont.systemFont(ofSize: 24, weight: .bold))
    )

    static let Headline3 = StringStyle(
        .font(UIFont.systemFont(ofSize: 20, weight: .semibold))
    )

    static let Headline4 = StringStyle(
        .font(UIFont.systemFont(ofSize: 18, weight: .semibold))
    )

    static let Caption = StringStyle(
        .font(UIFont.systemFont(ofSize: 14, weight: .regular))
    )

    static let Caption2 = StringStyle(
        .font(UIFont.systemFont(ofSize: 12, weight: .regular))
    )

    static let DateTime = StringStyle(
        .font(UIFont.systemFont(ofSize: 22, weight: .semibold))
    )

    static let Text = StringStyle(
        .font(UIFont.systemFont(ofSize: 15, weight: .regular)),
        .lineHeightMultiple(1.5)
    )

    static func registerAllStyles() {
        NamedStyles.shared.registerStyle(forName: "Headline1", style: Headline1)
        NamedStyles.shared.registerStyle(forName: "Headline2", style: Headline2)
        NamedStyles.shared.registerStyle(forName: "Headline3", style: Headline3)
        NamedStyles.shared.registerStyle(forName: "Headline4", style: Headline4)
        NamedStyles.shared.registerStyle(forName: "Caption", style: Caption)
        NamedStyles.shared.registerStyle(forName: "Caption2", style: Caption2)
        NamedStyles.shared.registerStyle(forName: "DateTime", style: DateTime)
    }
}
