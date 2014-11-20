//  SwiftKeychainTests.swift
//
// Copyright (c) 2014 Minubia (http://minubia.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import SwiftKeychain
import XCTest

class SwiftKeychainTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        deleteTestKey()
        super.tearDown()
    }
    
    func testAddGenericKey() {
        
        var attributes: [String: Any] = [
        "username":         "admin",
        "password":         "demo",
        "accessibility":    Accessibility.WhenUnlocked,
        "service":          NSBundle.mainBundle().bundleIdentifier,
        "accessgroup":      "swiftkeychaingroup",
        "description":      "SwiftKeychain Test Account",
        "comment":          "Used for testing purposes",
        "label":            "Test Account"
        ]
        
        let key = GenericKey(attributes: attributes)
        let resultCode: ResultCode = SwiftKeychain.add(key)

        XCTAssertEqual(resultCode, ResultCode.success)
    }
    
    func testFindKey() {
        
        // =============== Add A Test Key ===============
        var attributes: [String: Any] = [
            "username":         "admin",
            "password":         "demo",
            "accessibility":    Accessibility.WhenUnlocked,
            "service":          NSBundle.mainBundle().bundleIdentifier,
            "accessgroup":      "swiftkeychaingroup",
            "description":      "SwiftKeychain Test Account",
            "comment":          "Used for testing purposes",
            "label":            "Test Account"
        ]
        
        let key = GenericKey(attributes: attributes)
        let resultCode: ResultCode = SwiftKeychain.add(key)        
        
        var keyToBeFoundAttributes: [String: Any] = [
            "username":         "admin"
        ]
        
        let keyToBeFound = GenericKey(attributes: keyToBeFoundAttributes)
        // =============== Find a Key ===============
        let result = SwiftKeychain.find(keyToBeFound)
        XCTAssertEqual(result.resultCode, ResultCode.success)
    }
    
    func testUpdateKey() {
        
        // =============== Add A Test Key ===============
        var attributes: [String: Any] = [
            "username": "admin",
            "password": "demo",
            "accessibility": Accessibility.WhenUnlocked,
            "service": NSBundle.mainBundle().bundleIdentifier,
            "accessgroup": "swiftkeychaingroup",
            "description": "SwiftKeychain Test Account",
            "comment": "Used for testing purposes",
            "label": "Test Account"
        ]
        let key = GenericKey(attributes: attributes)
        let addResultCode: ResultCode = SwiftKeychain.add(key)
        XCTAssertEqual(addResultCode, ResultCode.success)
        
        // =============== Update a Key ===============
        
        let newPassword = "newpassword"
        
        var keyToBeUpdatedAttributes: [String: Any] = [
            "username": "admin",
            "password": newPassword
        ]
        let keyToBeUpdated = GenericKey(attributes: keyToBeUpdatedAttributes)
        
        let updateResultCode: ResultCode = SwiftKeychain.update(keyToBeUpdated)
        XCTAssertEqual(updateResultCode, ResultCode.success)
        
        // =============== Find a Key ===============
        
        var keyToBeFoundAttributes: [String: Any] = [
            "username": "admin"
        ]
        let keyToBeFound = GenericKey(attributes: keyToBeFoundAttributes)
        
        let searchResult = SwiftKeychain.find(keyToBeFound)
        XCTAssertEqual(searchResult.resultCode, ResultCode.success)
        
        XCTAssertEqual(searchResult.result as String, newPassword)
    }
    
    func deleteTestKey() {
        
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(
            objects:    [
                NSString(format: kSecClassGenericPassword),
                "",
                "admin"
            ],
            forKeys:    [
                NSString(format: kSecClass),
                NSString(format: kSecAttrService),
                NSString(format: kSecAttrAccount)
            ]
        )
        let statusCode: OSStatus = SecItemDelete(keychainQuery);
    }
}
