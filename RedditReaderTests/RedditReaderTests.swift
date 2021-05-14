//
//  RedditReaderTests.swift
//  RedditReaderTests
//
//  Created by Juan Carlos on 14/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import XCTest
import Combine
@testable import RedditReader

class RedditReaderTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRedditListViewModelFetch() throws {
        let viewModel = RedditListViewModel(listingService: MockListService.shared)
        
        var postsList: [RedditPostViewModel] = []
        let expectation = self.expectation(description: "Fetching Top Reddits")
        var didSinkInitialValue: Bool = false
        
        viewModel.postsList.sink { newValue in
            if !didSinkInitialValue {
                didSinkInitialValue.toggle()
                return
            }
            postsList = newValue
            expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.fetchPosts()
        
        waitForExpectations(timeout: 10)
        
        XCTAssertTrue(!postsList.isEmpty, "Fetched data properly")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
