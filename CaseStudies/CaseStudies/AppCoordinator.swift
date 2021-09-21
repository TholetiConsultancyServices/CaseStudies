//
//  AppCoordinator.swift
//  CaseStudies
//
//  Created by Appaji Tholeti on 26/01/2021.
//

import Foundation
import UIKit

class AppCoordinator: CoordinatorType {
    var parentCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType] = []

    private let window = UIWindow(frame: UIScreen.main.bounds)

    func start() {
        let coordinator = CaseStudyCollectionCoordinator(window: window)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

