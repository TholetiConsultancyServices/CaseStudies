//
//  CaseStudyDetailsViewModelTests.swift
//  CaseStudiesTests
//
//  Created by Appaji Tholeti on 28/01/2021.
//

import XCTest
@testable import CaseStudies


class CaseStudyDetailsViewModelTests: XCTestCase {

    private var service: MockCaseStudyService!
    private var sut: CaseStudyDetailsViewModel!

    override func setUpWithError() throws {
        service = MockCaseStudyService()
    }

    override func tearDownWithError() throws {
        service = nil
    }


    func testCaseStudyDetailsViewData() {
        // Given
        guard let response: CaseStudiesResponse = TestUtils().loadJson(filename: "MockCaseStudies") else {
            XCTFail()
            return
        }

        guard let caseStudy = response.caseStudies?[1] else {
            XCTFail()
            return
        }

        //When
        sut = CaseStudyDetailsViewModel(caseStudy: caseStudy, service: service)

        //Then
        XCTAssertEqual(sut.heading, "From Wallet to Smartphone")
        XCTAssertEqual(sut.sections.count, 5)
        let item = sut.sections[0].items[0]
        XCTAssertEqual(item, .text("sample text"))
    }
}
