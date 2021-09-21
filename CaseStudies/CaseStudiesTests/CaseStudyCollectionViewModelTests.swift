//
//  CaseStudyCollectionViewModelTests.swift
//  CaseStudiesTests
//
//  Created by Appaji Tholeti on 28/01/2021.
//

import XCTest
@testable import CaseStudies


class CaseStudyCollectionViewModelTests: XCTestCase {

    private var service: MockCaseStudyService!
    private var delegate: MockCaseStudyCollectionCoordinatorDelegate!

    private var sut: CaseStudyCollectionViewModel!

    override func setUpWithError() throws {
        service = MockCaseStudyService()
        delegate = MockCaseStudyCollectionCoordinatorDelegate()
        sut = CaseStudyCollectionViewModel(service: service, delegate: delegate)
    }

    override func tearDownWithError() throws {
        service = nil
        delegate = nil
        sut = nil
    }

    func testLoadCaseStudiesSuccessful() {
        // Given
        let expectation = self.expectation(description: "CaseStudies")

        guard let response: CaseStudiesResponse = TestUtils().loadJson(filename: "MockCaseStudies") else {
            XCTFail()
            return
        }

        service.fetchCaseStudiesGivenValue = response.caseStudies

        // When
        sut.loadCaseStudies { _ in
            expectation.fulfill()
        }

        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.caseStudies?.count, 10)
        guard let item = sut.caseStudies?[0] else {
            XCTFail()
            return
        }

        XCTAssertEqual(item.title, "Public Sector")
    }

    func testLoadCaseStudiesFailed() {
        // Given
        let expectation = self.expectation(description: "CaseStudies")

        service.fetchCaseStudiesGivenValue = nil

        var downloadStatus: DownloadStatus!

        // When
        sut.loadCaseStudies { status in
            downloadStatus = status
            expectation.fulfill()
        }

        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(downloadStatus, .failure("Unable to load CaseStudys, please try again."))
    }

}

class MockCaseStudyCollectionCoordinatorDelegate: CaseStudyCollectionCoordinatorDelegate {

    var didSelectCalled = false
    func didSelect(caseStudy: CaseStudy) {
        didSelectCalled = true
    }
}
