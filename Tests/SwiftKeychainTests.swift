//
//  SwiftKeychainTests.swift
//  SwiftKeychainTests
//
//  Created by Clinton on 09/11/14.
//  Copyright (c) 2014 Minubia. All rights reserved.
//

import SwiftKeychain
import XCTest

class SwiftKeychainTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddKey() {
        var kc: SwiftyKeychain = SwiftyKeychain(name: "test")
        let keychain = SwiftyKeychain(name: "test")
    }
    
}