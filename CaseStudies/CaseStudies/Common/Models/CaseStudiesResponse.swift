//
//  CaseStudies.swift
//  CaseStudies
//
//  Created by Appaji Tholeti on 26/01/2021.
//

import Foundation

struct CaseStudiesResponse: Decodable {

    let caseStudies: [CaseStudy]?

    enum CodingKeys: String, CodingKey {
        case caseStudies = "case_studies"
    }
}
