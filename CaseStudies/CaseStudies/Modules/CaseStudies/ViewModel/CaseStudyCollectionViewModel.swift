//
//  CaseStudyCollectionViewModel.swift
//  TheCaseStudyDB
//
//  Created by Appaji Tholeti on 27/01/2021.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit


protocol CaseStudyCollectionViewModelType {
    var title: String? { get }
    var caseStudies: [CaseStudyCollectionViewModel.CaseStudyItem]? { get }
    func fetchImage(imageURL: URL, completion: @escaping (UIImage?) -> Void)
    func didSelect(indexPath: IndexPath)
    func loadCaseStudies(completion: @escaping (DownloadStatus) -> Void)
}

enum DownloadStatus: Equatable {
    case successful
    case failure(String)
}

class CaseStudyCollectionViewModel: CaseStudyCollectionViewModelType {

    var title: String? { return "Case Studies" }
    private(set) var caseStudies: [CaseStudyItem]?
    
    private weak var delegate: CaseStudyCollectionCoordinatorDelegate?
    let service: CaseStudyServiceType

    struct CaseStudyItem {
        let title: String?
        let heading: String
        let subtitle: String?
        let imageURL: URL

        let caseStudy: CaseStudy

        init(_ caseStudy: CaseStudy) {
            title = caseStudy.vertical
            heading = caseStudy.teaser
            subtitle = caseStudy.client
            imageURL = caseStudy.heroImage
            self.caseStudy = caseStudy
        }
    }


    init(service: CaseStudyServiceType, delegate: CaseStudyCollectionCoordinatorDelegate?) {
        self.service = service
        self.delegate = delegate
    }

    func fetchImage(imageURL: URL, completion: @escaping (UIImage?) -> Void) {
        service.fetchCaseStudyImage(url: imageURL) { data in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
        }
    }

    func didSelect(indexPath: IndexPath) {
        guard let caseStudyItem = caseStudies?[indexPath.row] else {
            return
        }
        delegate?.didSelect(caseStudy: caseStudyItem.caseStudy)
    }

    func loadCaseStudies(completion: @escaping (DownloadStatus) -> Void) {
        service.fetchCaseStudies { [weak self] caseStudies, error in
            DispatchQueue.main.async {
                switch error {
                case .none:
                    self?.caseStudies =  caseStudies?.map({ CaseStudyItem($0) })
                    completion(.successful)
                case .cannotFetchData:
                    completion(.failure("Unable to load CaseStudys, please try again."))
                case .networkOffline:
                    completion(.failure("Network in not available, Please check internet connection and try again."))
                }
            }
        }
    }
}
