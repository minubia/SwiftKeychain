//  SwiftKeychain.swift
//
// Copyright (c) 2015 Minubia (http://minubia.com)
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
    // =============== Warning: -25243 is undocumented by Apple ===============
    case noAccessForItem        = -25243
    
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
            case .noAccessForItem:
                return "No Access For Item"
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

        var attributes = [
            kSecClassKey:           NSString(format: kSecClassGenericPassword),
            NSString(format: kSecAttrAccount):     genericKey.account,
            NSString(format: kSecAttrAccessible):  genericKey.accessibility,
            NSString(format: kSecAttrDescription): genericKey.description,
            NSString(format: kSecAttrComment):     genericKey.comment,
            NSString(format: kSecAttrLabel):       genericKey.label,
            NSString(format: kSecAttrService):     genericKey.service
            ] as NSMutableDictionary
        
        // Ignore the access group if running on the simulator.
        //
        // Apps that are built for the simulator aren't signed, so there's no keychain access group
        // for the simulator to check. This means that all apps can see all keychain items when run
        // on the simulator.
        //
        // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
        // simulator will return -25243 (errSecNoAccessForItem).
        #if (!(arch(i386) || arch(x86_64)) && os(iOS))
            attributes[NSString(format: kSecAttrAccessGroup)] = genericKey.accessGroup
        #endif
        
        attributes[NSString(format: kSecValueData)] = genericKey.password.dataUsingEncoding(NSUTF8StringEncoding)

        let statusCode: OSStatus = SecItemAdd(attributes, nil);
        resultCode = ResultCode(rawValue: statusCode)
    }
    
    return resultCode
}

public func find<T>(inout key: T) -> (ResultCode) {
    
    var resultCode :    ResultCode!
    let kSecClassKey = NSString(format: kSecClass)
    
    if key is GenericKey{
        let genericKey = key as GenericKey
        
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(
            objects:    [
                NSString(format: kSecClassGenericPassword),
                genericKey.service,
                genericKey.account,
                kCFBooleanTrue,
                kCFBooleanTrue,
                NSString(format: kSecMatchLimitOne),
            ],
            forKeys:    [
                NSString(format: kSecClass),
                NSString(format: kSecAttrService),
                NSString(format: kSecAttrAccount),
                NSString(format: kSecReturnData),
                NSString(format: kSecReturnAttributes),
                NSString(format: kSecMatchLimit),
            ]
        )

        var result: Unmanaged<AnyObject>?
        let statusCode: OSStatus = SecItemCopyMatching(keychainQuery, &result);        
        resultCode = ResultCode(rawValue: statusCode)
        
        if(resultCode == ResultCode.success){
            let foundAttributes = result?.takeUnretainedValue() as CFMutableDictionaryRef
            //=============== Username ===============
            var usernameValue = CFDictionaryGetValue(foundAttributes, unsafeAddressOf(kSecAttrAccount))
            let usernameString: NSString = unsafeBitCast(usernameValue, NSString.self)
            
            //=============== Password ===============
            var passwordValue = CFDictionaryGetValue(foundAttributes, unsafeAddressOf(kSecValueData))
            let passwordData: NSData = unsafeBitCast(passwordValue, NSData.self)
            let password = NSString(data: passwordData, encoding: NSUTF8StringEncoding)
            
            //=============== Description ===============
            var descriptionValue = CFDictionaryGetValue(foundAttributes, unsafeAddressOf(kSecAttrDescription))
            let descriptionString: NSString = unsafeBitCast(descriptionValue, NSString.self)
            
            //=============== Comment ===============
            var commentValue = CFDictionaryGetValue(foundAttributes, unsafeAddressOf(kSecAttrComment))
            let commentString: NSString = unsafeBitCast(commentValue, NSString.self)
            
            //=============== isNegative ===============
            var isNegativeValue = CFDictionaryGetValue(foundAttributes, unsafeAddressOf(kSecAttrIsNegative))
            let isNegativeBool: CFBooleanRef = unsafeBitCast(isNegativeValue, CFBooleanRef.self)
            
            genericKey.account          = usernameString
            genericKey.password         = password!
            genericKey.description      = descriptionString
            genericKey.comment          = commentString
            genericKey.isNegative       = isNegativeBool
            
            return resultCode
        }
    }

    return resultCode
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
        attributes[NSString(format: kSecAttrDescription)] = genericKey.description
        attributes[NSString(format: kSecAttrComment)] = genericKey.comment
        attributes[NSString(format: kSecAttrIsNegative)] = genericKey.isNegative
        
        // Ignore the access group if running on the simulator.
        //
        // Apps that are built for the simulator aren't signed, so there's no keychain access group
        // for the simulator to check. This means that all apps can see all keychain items when run
        // on the simulator.
        //
        // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
        // simulator will return -25243 (errSecNoAccessForItem).
        #if (!(arch(i386) || arch(x86_64)) && os(iOS))
            let kSecAttrAccessGroupKey = NSString(format: kSecAttrAccessGroup)
            attributes[kSecAttrAccessGroupKey] = genericKey.accessGroup
        #endif
        
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
