//
//  NowPlayingCaseStudysCoordinator.swift
//  TheCaseStudyDB
//
//  Created by Appaji Tholeti on 23/01/2021.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

protocol  CaseStudyCollectionCoordinatorDelegate: AnyObject {
    func didSelect(caseStudy: CaseStudy)
}

class CaseStudyCollectionCoordinator: CoordinatorType {
    var parentCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType] = []

    private var window: UIWindow
    private lazy var navigationController: UINavigationController  = {
        return UINavigationController()
    }()

    private var service: CaseStudyService

    init(window: UIWindow, service: CaseStudyService = CaseStudyService()) {
        self.window = window
        self.service = service
    }

    func start() {
        let viewModel = CaseStudyCollectionViewModel(service: service, delegate: self)
        let viewController = CaseStudyCollectionViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension CaseStudyCollectionCoordinator: CaseStudyCollectionCoordinatorDelegate {
    func didSelect(caseStudy: CaseStudy) {
        let coordinator = CaseStudyDetailsCoordinator(caseStudy: caseStudy, navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
