//
//  StepSupportable.swift
//  Spendo
//
//  Created by Igors Nemenonoks on 17/05/2019.
//  Copyright © 2019 Chili Labs. All rights reserved.
//

import Foundation
import RxFlow

protocol StepSupportable: Stepper {
    var defaultStep: Step { get }
    func triggerDefaultStep()
}

extension StepSupportable {
    func triggerDefaultStep() {
        self.steps.accept(defaultStep)
    }
}
