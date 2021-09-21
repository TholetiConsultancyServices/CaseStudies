//
//  TestUtils.swift
//  CaseStudiesTests
//
//  Created by Appaji Tholeti on 28/01/2021.
//


import XCTest

@testable import CaseStudies

class TestUtils {

    func loadJson<T: Decodable>(filename fileName: String) -> T? {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: fileName, withExtension: "json") else {
            return nil
        }

        guard let data = try? Data(contentsOf: url) else {
            return nil
        }

        return T(jsonData: data)
    }
}
