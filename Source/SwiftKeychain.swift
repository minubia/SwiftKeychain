//  SwiftKeychain.swift
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

import Foundation

public enum Accessibility : RawRepresentable {
    
    case WhenUnlocked, AfterFirstUnlock, Always,
    WhenPasscodeSetThisDeviceOnly, WhenUnlockedThisDeviceOnly,
    AfterFirstUnlockThisDeviceOnly, AlwaysThisDeviceOnly
    
    public init?(rawValue: String) {
        if rawValue == String(kSecAttrAccessibleWhenUnlocked) {
            self = WhenUnlocked
        }
        else if rawValue == String(kSecAttrAccessibleAfterFirstUnlock) {
            self = AfterFirstUnlock
        }
        else if rawValue == String(kSecAttrAccessibleAlways) {
            self = Always
        }
        else if rawValue == String(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly) {
            self = WhenPasscodeSetThisDeviceOnly
        }
        else if rawValue == String(kSecAttrAccessibleWhenUnlockedThisDeviceOnly) {
            self = WhenUnlockedThisDeviceOnly
        }
        else if rawValue == String(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly) {
            self = AfterFirstUnlockThisDeviceOnly
        }
        else if rawValue == String(kSecAttrAccessibleAlwaysThisDeviceOnly) {
            self = AlwaysThisDeviceOnly
        }
        else {
            return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case WhenUnlocked:
            return String(kSecAttrAccessibleWhenUnlocked)
        case AfterFirstUnlock:
            return String(kSecAttrAccessibleAfterFirstUnlock)
        case Always:
            return String(kSecAttrAccessibleAlways)
        case WhenPasscodeSetThisDeviceOnly:
            return String(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
        case WhenUnlockedThisDeviceOnly:
            return String(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
        case AfterFirstUnlockThisDeviceOnly: 
            return String(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
        case AlwaysThisDeviceOnly: 
            return String(kSecAttrAccessibleAlwaysThisDeviceOnly)
        }
    }	
}

public enum ResultCode : Int32, Printable {
    
    case success                = 0
    case unimplemented          = -4
    case param                  = -50
    case allocate               = -108
    case notAvailable           = -25291
    case authFailed             = -25293
    case duplicateItem          = -25299
    case itemNotFound           = -25300
    case interactionNotAllowed  = -25308
    case decode                 = -26275
    
    
    public var description : String {
        get {
            switch(self) {
            case .success:
                return "No error"
            case .unimplemented:
                return "Function or operation not implemented"
            case .param:
                return "One or more parameters passed to the function were not valid"
            case .allocate:
                return "Failed to allocate memory"
            case .notAvailable:
                return "No trust results are available"
            case .authFailed:
                return "Authorization/Authentication failed"
            case .duplicateItem:
                return "The item already exists"
            case .itemNotFound:
                return "The item cannot be found"
            case .interactionNotAllowed:
                return "Interaction with the Security Server is not allowed"
            case .decode:
                return "Unable to decode the provided data"
            default:
                return "Unknown"
            }
        }
    }
}

public func add<Key>(key: Key ) -> ResultCode {
    
    var resultCode : ResultCode!
    let kSecClassKey = NSString(format: kSecClass)

    if key is GenericKey{
        let genericKey = key as GenericKey
        
        // =============== Mandatory Attributes ===============
        let kSecClassValue      = NSString(format: kSecClassGenericPassword)
        let kSecAttrAccountKey   = NSString(format: kSecAttrAccount)
        let kSecValueDataKey    = NSString(format: kSecValueData)
        
        // =============== Optional Attributes ===============
        let kSecAttrAccessibleKey = NSString(format: kSecAttrAccessible)
        let kSecAttrAccessGroupKey = NSString(format: kSecAttrAccessGroup)
        let kSecAttrDescriptionKey = NSString(format: kSecAttrDescription)
        let kSecAttrCommentKey = NSString(format: kSecAttrComment)
        let kSecAttrLabelKey = NSString(format: kSecAttrLabel)
        let kSecAttrServiceKey = NSString(format: kSecAttrService)

        var attributes = [
            kSecClassKey:           kSecClassValue,
            kSecAttrAccountKey:     genericKey.account,
            kSecAttrAccessibleKey:  genericKey.accessibility,
            //kSecAttrAccessGroupKey: genericKey.accessGroup,
            kSecAttrDescriptionKey: genericKey.description,
            kSecAttrCommentKey:     genericKey.comment,
            kSecAttrLabelKey:       genericKey.label,
            kSecAttrServiceKey:     genericKey.service
            ] as NSMutableDictionary
        
        attributes[kSecValueDataKey] = genericKey.password.dataUsingEncoding(NSUTF8StringEncoding)

        let statusCode: OSStatus = SecItemAdd(attributes, nil);
        resultCode = ResultCode(rawValue: statusCode)
    }
    
    return resultCode
}

public func find(key: Key) -> (resultCode: ResultCode, result: AnyObject) {
    
    var resultCode :    ResultCode!
    var output:         AnyObject! = ""
    let kSecClassKey = NSString(format: kSecClass)
    
    if key is GenericKey{
        let genericKey = key as GenericKey
        
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(
            objects:    [
                NSString(format: kSecClassGenericPassword),
                genericKey.service,
                genericKey.account,
                kCFBooleanTrue,
                NSString(format: kSecMatchLimitOne),
            ],
            forKeys:    [
                NSString(format: kSecClass),
                NSString(format: kSecAttrService),
                NSString(format: kSecAttrAccount),
                NSString(format: kSecReturnData),
                NSString(format: kSecMatchLimit),
            ]
        )
        
        var result: Unmanaged<AnyObject>?
        let statusCode: OSStatus = SecItemCopyMatching(keychainQuery, &result);        
        resultCode = ResultCode(rawValue: statusCode)

        if(resultCode == ResultCode.success){
            let opaque = result?.toOpaque()
            if let op = opaque? {
            
                let retrievedData = Unmanaged<NSData>.fromOpaque(op).takeUnretainedValue()
                output = NSString(data: retrievedData, encoding: NSUTF8StringEncoding)
            }
        }
    }
    
    return (resultCode, output)
}

public func update<Key>(key: Key ) -> ResultCode {
    
    var resultCode : ResultCode!
    let kSecClassKey = NSString(format: kSecClass)
    
    if key is GenericKey{
        let genericKey = key as GenericKey
        
        // =============== Query to match the key to be updated ===============
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(
            objects: [
                NSString(format: kSecClassGenericPassword),
                genericKey.account
            ],
            forKeys: [
                NSString(format: kSecClass),
                NSString(format: kSecAttrAccount)
            ]
        )

        // =============== Attributes to be updated ===============

        var attributes = NSMutableDictionary()
        attributes[NSString(format: kSecValueData)] = genericKey.password.dataUsingEncoding(NSUTF8StringEncoding)
        
        let statusCode: OSStatus = SecItemUpdate(keychainQuery,attributes);
        resultCode = ResultCode(rawValue: statusCode)
    }
    return resultCode
}

public func delete<Key>(key: Key ) -> ResultCode {
    
    var resultCode : ResultCode!
    let kSecClassKey = NSString(format: kSecClass)
    
    if key is GenericKey{
        let genericKey = key as GenericKey
        
        // =============== Query to match the key to be deleted ===============
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(
            objects: [
                NSString(format: kSecClassGenericPassword),
                genericKey.account
            ],
            forKeys: [
                NSString(format: kSecClass),
                NSString(format: kSecAttrAccount)
            ]
        )
        
        let statusCode: OSStatus = SecItemDelete(keychainQuery);
        resultCode = ResultCode(rawValue: statusCode)
    }
    return resultCode
}
