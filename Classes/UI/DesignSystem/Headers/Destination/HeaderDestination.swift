//
//  HeaderDestination.swift
//  DesignSystemExample
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import UIKit

final class HeaderDestination: UIView {
    static let height: CGFloat = 400
    static var minimumHeight: CGFloat { return 100 + UIApplication.shared.statusBarFrame.height }

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.topConstraint.constant = UIApplication.shared.statusBarFrame.height + 4
    }
}
