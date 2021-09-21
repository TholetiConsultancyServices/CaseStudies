//
//  CaseStudiesResponseTests.swift
//  CaseStudiesTests
//
//  Created by Appaji Tholeti on 28/01/2021.
//

import XCTest

@testable import CaseStudies


class CaseStudiesResponseTests: XCTestCase {

    func testCaseStudiesResponseModel() {
        guard let response: CaseStudiesResponse = TestUtils().loadJson(filename: "MockCaseStudies") else {
            XCTAssertThrowsError("unable to load file")
            return
        }
        XCTAssertEqual(response.caseStudies?.count, 10)
    }

    func testCaseStudyModel() {
        guard let response: CaseStudiesResponse = TestUtils().loadJson(filename: "MockCaseStudies") else {
            XCTAssertThrowsError("unable to load file")
            return
        }

        let caseStudy = response.caseStudies![0]
        XCTAssertEqual(caseStudy.client, "TfL")
        XCTAssertEqual(caseStudy.title, "A World-First For Apple iPad")
        XCTAssertEqual(caseStudy.vertical, "Public Sector")
        XCTAssertEqual(caseStudy.sections.count, 4)

        let section = caseStudy.sections[1]
        XCTAssertEqual(section.title, "Reimagining brake testing")
        XCTAssertEqual(section.body.count, 3)
    }

}
