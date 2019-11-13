//
//  DataLoaderTests.swift
//  MetroTests
//
//  Created by Алексей Махутин on 13.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import XCTest
@testable import Metro

class DataLoaderTests: XCTestCase {
    
    func testTryLoadData() {
        let loader = DataLoader.share
        let data = loader.laodFileToData(filename: "data", wtihExtension: "json")
        let dataNil = loader.laodFileToData(filename: "Foo", wtihExtension: "Bar")

        XCTAssertNotNil(data)
        XCTAssertNil(dataNil)
    }
    
}
