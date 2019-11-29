//
//  DataFetcherTest.swift
//  MetroTests
//
//  Created by Алексей Махутин on 20.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import XCTest
@testable import Metro

class DataFetcherTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetFetchData() {
        let fecther = DataFetcher.share
        let json = fecther.getMetroData()
        XCTAssertNotNil(json)
    }



}
