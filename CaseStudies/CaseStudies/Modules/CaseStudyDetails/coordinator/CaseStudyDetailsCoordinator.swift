//
//  NowPlayingCaseStudysCoordinator.swift
//  TheCaseStudyDB
//
//  Created by Appaji Tholeti on 23/01/2021.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

class CaseStudyDetailsCoordinator: CoordinatorType {
    var parentCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType] = []

    private let navigationController: UINavigationController
    private let service: CaseStudyService
    private let caseStudy: CaseStudy

    init(caseStudy: CaseStudy, navigationController: UINavigationController, service: CaseStudyService = CaseStudyService()) {
        self.navigationController = navigationController
        self.service = service
        self.caseStudy = caseStudy
    }

    func start() {
        let viewModel = CaseStudyDetailsViewModel(caseStudy: caseStudy, service: service)
        let viewController = CaseStudyDetailsViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
