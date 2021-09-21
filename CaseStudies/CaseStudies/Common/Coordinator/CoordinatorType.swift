//
//  Coordinatortype.swift
//  CaseStudies
//
//  Created by Appaji Tholeti on 26/01/2021.
//

import Foundation
import UIKit

protocol CoordinatorType: AnyObject {
    var parentCoordinator: CoordinatorType? { get set }
    var childCoordinators: [CoordinatorType] { get set }
    func start()
    func didFinish(coordinator: CoordinatorType)
}

extension CoordinatorType {
    func didFinish(coordinator: CoordinatorType) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}


