//
//  CasrStudyService.swift
//  CaseStudies
//
//  Created by Appaji Tholeti on 26/01/2021.
//

import Foundation
import UIKit


enum CaseStudyServiceError {
    case none
    case networkOffline
    case cannotFetchData
}

enum CaseStudyServiceResult<T> {
    case Success(T)
    case Failure(CaseStudyServiceError)
}

protocol CaseStudyServiceType {
    func fetchCaseStudyImage(url: URL, completionHandler: @escaping (Data?) -> Void)
    func fetchCaseStudies(completionHandler: @escaping ([CaseStudy]?, CaseStudyServiceError) -> Void)
}


struct CaseStudyServiceEndPoints {
    private static let root = "https://raw.githubusercontent.com/theappbusiness/engineering-challenge/main/endpoints/v1"
    static let caseStudies = "\(root)/caseStudies.json"
}

struct CaseStudyService: CaseStudyServiceType {

    private let networkManager: NetworkManagerType

    init(networkManager: NetworkManagerType = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchCaseStudies(completionHandler: @escaping ([CaseStudy]?, CaseStudyServiceError) -> Void) {

        guard let url =  URL(string: CaseStudyServiceEndPoints.caseStudies) else {
            completionHandler(nil, .cannotFetchData)
            return
        }

        networkManager.dowloadJSONData(with: url, requestHeaders: nil) { (result: Result<CaseStudiesResponse>) in
            switch result {
            case .Success(let response):
                completionHandler(response.caseStudies, .none)
            case .Failure(let error):
                completionHandler(nil, error == .offline ? .networkOffline : .cannotFetchData )
            }
        }
    }

    func fetchCaseStudyImage(url: URL, completionHandler: @escaping (Data?) -> Void) {

        networkManager.dowloadImageData(with: url, requestHeaders: nil) { (result: Result<Data>) in
            switch result {
            case .Success(let data):
                completionHandler(data)
            case .Failure(_):
                completionHandler(nil)
            }
        }
    }
}
