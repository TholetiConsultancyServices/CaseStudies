//
//  CaseStudyDetailsViewModel.swift
//  TheCaseStudyDB
//
//  Created by Appaji Tholeti on 27/01/2021.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

protocol CaseStudyDetailsViewModelType {
    var title: String? { get }
    var heading: String? { get }
    var mainImageURL: URL { get }
    var sections: [CaseStudyDetailsViewModel.Section] { get }
    func fetchImage(imageURL: URL, completion: @escaping (UIImage?) -> Void)
}

struct CaseStudyDetailsViewModel: CaseStudyDetailsViewModelType {
    
    let title: String?
    let heading: String?
    let mainImageURL: URL
    let sections: [Section]

    struct Section {
        let title: String?
        private(set) var items: [ItemType] = []

        enum ItemType: Equatable {
            case text(String)
            case image(URL)
        }

        init(_ section: CaseStudy.Section) {
            self.title = section.title
            for element in section.body {
                switch element {
                case .image(let url):
                    items.append(.image(url))
                case .text(let text):
                    items.append(.text(text))
                }
            }
        }
    }

    private let service: CaseStudyServiceType
    private let caseStudy: CaseStudy

    init(caseStudy: CaseStudy, service: CaseStudyServiceType) {
        self.service = service
        self.caseStudy = caseStudy
        title = caseStudy.client
        heading = caseStudy.title
        mainImageURL = caseStudy.heroImage
        sections = caseStudy.sections.map{ Section($0) }
    }

    func fetchImage(imageURL: URL, completion: @escaping (UIImage?) -> Void) {
        service.fetchCaseStudyImage(url: imageURL) { data in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
        }
    }
}
