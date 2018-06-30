//
//  PartsProteinTests.swift
//  PartsProteinTests
//
//  Created by Vladislav on 06.06.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import XCTest
@testable import PartsProtein



class PartsProteinTests: XCTestCase {
    
    var part:Part!
    
    override func setUp() {
        super.setUp()
        part = Part()
    }
    
    override func tearDown() {
        part = nil
        super.tearDown()
    }
    
    func testCreationOfPart() {
        part.quantity = 50
        XCTAssertEqual(part.quantity, 50)
    }
    
    
    
    
    
}
