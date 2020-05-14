//
//  UIColor+Styles.swift
//  DesignSystemExample
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class var mainText: UIColor {
        return UIColor.color(with: "#333333")
    }

    class var captionText: UIColor {
        return UIColor.color(with: "#888888")
    }

    class var placeholder: UIColor {
        return UIColor.color(with: "#EFEFEF")
    }

    class func color(with hex: String) -> UIColor {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                       alpha: 1)
    }
}
