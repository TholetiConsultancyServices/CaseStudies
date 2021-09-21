//
//  MockUseCaseService.swift
//  CaseStudiesTests
//
//  Created by Appaji Tholeti on 28/01/2021.
//

import Foundation

@testable import CaseStudies

class MockCaseStudyService: CaseStudyServiceType {
    var fetchCaseStudiesGivenValue: [CaseStudy]?
    var fetchCaseStudyImageReturnValue: Data?

    func fetchCaseStudyImage(url: URL, completionHandler: @escaping (Data?) -> Void) {
        completionHandler(fetchCaseStudyImageReturnValue)
    }

    func fetchCaseStudies(completionHandler: @escaping ([CaseStudy]?, CaseStudyServiceError) -> Void) {
        if fetchCaseStudiesGivenValue == nil {
            completionHandler(nil, .cannotFetchData)
        } else {
            completionHandler(fetchCaseStudiesGivenValue, .none)
        }
    }
}
