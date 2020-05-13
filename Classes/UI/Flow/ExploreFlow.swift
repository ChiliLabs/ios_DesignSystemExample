//
//  ExploreFlow.swift
//  DesignSystemExample
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa

final class ExploreFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    let rootViewController: UINavigationController = {
        let nc = NavigationController()
        nc.navigationBar.isHidden = true
        return nc
    }()

    private let bag = DisposeBag()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? FlowStep.Explore else { return .none }
        switch step {
        case .main:
            return navigateToDashboard()
        case .page:
            return navigateToPage()
        case .pop:
            self.rootViewController.popViewController(animated: true)
            return .none
        }
    }

    private func navigateToDashboard() -> FlowContributors {
        let vm = ExploreVM()
        let vc = Screen(viewModel: vm)
        self.rootViewController.viewControllers = [vc]
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }

    private func navigateToPage() -> FlowContributors {
        let vm = ExploreVM()
        let vc = DestinationVC(viewModel: vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}

final class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }
}
