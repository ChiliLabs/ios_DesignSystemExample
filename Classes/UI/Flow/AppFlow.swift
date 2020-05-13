//
// Created by Igors Nemenonoks on 2019-05-10.
// Copyright (c) 2019 Chili Labs. All rights reserved.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa
import RxSwift

final class AppFlow: Flow {
    var root: Presentable {
        return self.rootWindow
    }

    private let rootWindow: UIWindow

    init(withWindow window: UIWindow) {
        self.rootWindow = window
    }

    func navigate(to step: Step) -> FlowContributors {
        switch step {
        case let authStep as FlowStep.Explore:
            return handleExploreNavigation(for: authStep)
        default:
            return .none
        }
    }

    private func handleExploreNavigation(for step: FlowStep.Explore) -> FlowContributors {
        let mainFlow = ExploreFlow()
        Flows.whenReady(flow1: mainFlow) { [unowned self] (root) in
            self.rootWindow.rootViewController = root
        }

        return .one(flowContributor: .contribute(withNextPresentable: mainFlow,
                                                 withNextStepper: OneStepper(withSingleStep: step)))
    }
}

final class AppStepper: Stepper {

    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    var initialStep: Step {
        return FlowStep.Explore.main
    }
}
