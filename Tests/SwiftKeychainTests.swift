//  SwiftKeychainTests.swift
//
// Copyright (c) 2016 Minubia (http://minubia.com)
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
        deleteTestKey()
        clearKeychain()
        super.setUp()
    }
    
    override func tearDown() {
        deleteTestKey()
        clearKeychain()
        super.tearDown()
    }
    
    func testAddGenericKey() {
        
        let attributes: [String: Any] = [
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
        let attributes: [String: Any] = [
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
        SwiftKeychain.add(key)
        
        let keyToBeFoundAttributes: [String: Any] = [
            "username":         "admin"
        ]
        
        var keyToBeFound = GenericKey(attributes: keyToBeFoundAttributes)
        // =============== Find a Key ===============
        let foundResultCode = SwiftKeychain.find(&keyToBeFound)
        XCTAssertEqual(foundResultCode, ResultCode.success)
    }
    
    func testUpdateKey() {
        
        // =============== Add A Test Key ===============
        let attributes: [String: Any] = [
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
        let newPassword     = "newpassword"
        let newDescription  = "SwiftKeychain Test Account Updated"
        let newComment      = "Comment updated"
        let newIsNegative   = true
        
        let keyToBeUpdatedAttributes: [String: Any] = [
            "username": "admin",
            "password": newPassword,
            "description": newDescription,
            "comment": newComment,
            "isNegative": newIsNegative
        ]
        let keyToBeUpdated = GenericKey(attributes: keyToBeUpdatedAttributes)
        
        let updateResultCode: ResultCode = SwiftKeychain.update(keyToBeUpdated)
        XCTAssertEqual(updateResultCode, ResultCode.success)
        
        // =============== Find a Key ===============
        let keyToBeFoundAttributes: [String: Any] = [
            "username": "admin",
        ]
        var keyToBeFound = GenericKey(attributes: keyToBeFoundAttributes)
        
        let resultCode = SwiftKeychain.find(&keyToBeFound)
        XCTAssertEqual(resultCode, ResultCode.success)

        XCTAssertEqual(keyToBeFound.password as String, newPassword)
        XCTAssertEqual(keyToBeFound.description as String, newDescription)
        XCTAssertEqual(keyToBeFound.comment as String, newComment)
        XCTAssertTrue(keyToBeFound.isNegative as Bool)
        
    }
    
    func testDeleteKey() {
        
        // =============== Add A Test Key ===============
        let attributes: [String: Any] = [
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
        
        // =============== Delete a Key ===============
        let keyToBeDeletedAttributes: [String: Any] = [
            "username": "admin"
        ]
        let keyToBeDeleted = GenericKey(attributes: keyToBeDeletedAttributes)
        
        let deleteResultCode: ResultCode = SwiftKeychain.delete(keyToBeDeleted)
        XCTAssertEqual(deleteResultCode, ResultCode.success)
    }
    
    func deleteTestKey() {
        
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(
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
        SecItemDelete(keychainQuery);
    }
    
    func clearKeychain() {
        
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(
            objects: [
                NSString(format: kSecClassGenericPassword)
            ],
            forKeys: [
                NSString(format: kSecClass)
            ]
        )
        
        SecItemDelete(keychainQuery);
    }
}
