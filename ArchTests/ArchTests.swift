//
//  ArchTests.swift
//  ArchTests
//
//  Created by Munendra Singh on 17/12/20.
//

import XCTest
@testable import Arch

class ArchTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let urlManager = URLManager()
        let url = URL(string: urlManager.countyFacts)
        URLProtocolMock.testURLs = [url: "Success"]
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        NetworkManager.main.setMockSession(session: session)
        
        let viewModel = ViewModel()
        let expectation = self.expectation(description: "Success Test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           XCTAssertEqual(viewModel.getTitle(), "About Canada")
           XCTAssertEqual(viewModel.numberOfSection, 1)
            XCTAssertEqual(viewModel.numberOfRowsInSection(1), 3)
            
            let countryViewModel:CountryViewModel = viewModel.country(0)
            XCTAssertNotNil(countryViewModel)
            XCTAssertEqual(countryViewModel.title, "Beavers")
            XCTAssertNotNil(countryViewModel.description)
            XCTAssertNotNil(countryViewModel.imgUrl)
            
            let countryViewModel2:CountryViewModel = viewModel.country(1)
            XCTAssertNotNil(countryViewModel2)
            XCTAssertEqual(countryViewModel2.title, "Flag")
            XCTAssertNotNil(countryViewModel2.description)
            XCTAssertNotNil(countryViewModel2.imgUrl)
            
            let countryViewModel3:CountryViewModel = viewModel.country(2)
            XCTAssertNotNil(countryViewModel3)
            XCTAssertEqual(countryViewModel3.title, "Transportation")
            XCTAssertNotNil(countryViewModel3.description)
            XCTAssertNotNil(countryViewModel3.imgUrl)
            
            expectation.fulfill()
        }
        viewModel.getList()
        waitForExpectations(timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
