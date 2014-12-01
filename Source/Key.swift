//  Key.swift
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

protocol KeyProtocol {
    
    var accessibility:  CFTypeRef { get set }
    var accessGroup:    CFStringRef { get set }
    var label:          CFStringRef { get set }
}

protocol PasswordKeyProtocol: KeyProtocol {
    
    var account:            CFStringRef { get set }
    var isNegative:         CFBooleanRef { get set }
    var description:        CFStringRef { get set }
    var comment:            CFStringRef { get set }
    var creator:            CFNumberRef { get set }
    var type:               CFNumberRef { get set }
    var isInvisible:        CFBooleanRef { get set }
    var creationDate:       CFDateRef { get }
    var modificationDate:   CFDateRef { get }
    
    var password:           NSString { get set }
}


public class Key: KeyProtocol {
    
    private var _accessibility:     CFTypeRef = kSecAttrAccessibleWhenUnlocked
    private var _accessGroup:       CFStringRef = ""
    private var _label:             CFStringRef = ""
    
    var accessibility: CFTypeRef {
        get {
            return _accessibility
        }
        set {
            _accessibility = newValue
        }
    }
    
    var accessGroup: CFStringRef {
        get {
            return _accessGroup
        }
        set {
            _accessGroup = newValue
        }
    }
    
    var label: CFStringRef {
        get {
            return _label
        }
        set {
            _label = newValue
        }
    }
    
    public init(attributes: Dictionary<String, Any>) {
        
        if((attributes["accessibility"]) != nil){
            switch attributes["accessibility"] as Accessibility {
            case .WhenUnlocked:
                _accessibility = kSecAttrAccessibleWhenUnlocked
            case .AfterFirstUnlock:
                _accessibility = kSecAttrAccessibleAfterFirstUnlock
            case .AfterFirstUnlockThisDeviceOnly:
                _accessibility = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            case .Always:
                _accessibility = kSecAttrAccessibleAlways
            case .AlwaysThisDeviceOnly:
                _accessibility = kSecAttrAccessibleAlwaysThisDeviceOnly
            case .WhenPasscodeSetThisDeviceOnly:
                _accessibility = kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
            case .WhenUnlockedThisDeviceOnly:
                _accessibility = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
            default:
                _accessibility = kSecAttrAccessibleWhenUnlocked                
            }
        }
        
        if((attributes["accessgroup"]) != nil){
            _accessGroup    = attributes["accessgroup"] as CFStringRef
        }
        
        if((attributes["label"]) != nil){
            _label    = attributes["label"] as CFStringRef
        }
    }
}

public class PasswordKey: Key, PasswordKeyProtocol {
    
    private var _creationDate:      CFDateRef!
    private var _modificationDate:  CFDateRef!
    private var _description:       CFStringRef = ""
    private var _comment:           CFStringRef = ""
    private var _creator:           CFNumberRef!
    private var _account:           CFStringRef!
    private var _isInvisible:       CFBooleanRef!
    private var _isNegative:        CFBooleanRef!
    private var _type:              CFNumberRef!
    
    private var _password:          NSData!
    
    var creationDate: CFDateRef {
        get {
            return _creationDate
        }
    }
    
    var modificationDate: CFDateRef {
        get {
            return _modificationDate
        }
    }
    
    var description: CFStringRef {
        get {
            return _description
        }
        set {
            _description = newValue
        }
    }
    
    var comment: CFStringRef {
        get {
            return _comment
        }
        set {
            _comment = newValue
        }
    }
    
    var creator: CFNumberRef {
        get {
            return _creator
        }
        set {
            _creator = newValue
        }
    }
    
    var account: CFStringRef {
        get {
            return _account
        }
        set {
            _account = newValue
        }
    }
    
    var isInvisible: CFBooleanRef {
        get {
            return _isInvisible
        }
        set {
            _isInvisible = newValue
        }
    }
    
    var isNegative: CFBooleanRef {
        get {
            return _isNegative
        }
        set {
            _isNegative = newValue
        }
    }
    
    var type: CFNumberRef {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
    
    var password: NSString {
        get {
            return NSString(data: _password, encoding: NSUTF8StringEncoding)!
        }
        set {
            _password = newValue.dataUsingEncoding(NSUTF8StringEncoding)
        }
    }
    
    public override init(attributes: Dictionary<String, Any>){
        
        super.init(attributes: attributes)
        account     = attributes["username"] as String
        if((attributes["password"]) != nil){
        password    = attributes["password"] as String
        }
    }
}

public class GenericKey: PasswordKey {
    
    private var _service:           CFStringRef = ""
    private var _generic:           CFDataRef!
    
    var service: CFStringRef {
        get {
            return _service
        }
        set {
            _service = newValue
        }
    }
    
    var generic: CFDataRef {
        get {
            return _generic
        }
        set {
            _generic = newValue
        }
    }
    
    public required override init(attributes: Dictionary<String, Any>) {
        
        super.init(attributes: attributes)
        
         _service        = NSBundle.mainBundle().bundleIdentifier ?? ""
        if((attributes["service"]) is String){
            _service = attributes["service"] as CFStringRef
        }        
        
        if((attributes["generic"]) != nil){
            _generic = attributes["generic"] as NSData
        }
    }
}

/*
TODO: Implement these classes

public class InternetKey: Key, KeyProtocol {
}

public class Certificate: Key, KeyProtocol {
}

public class PrivateKey: Key, KeyProtocol {
}

public class Identity: Key, KeyProtocol {
}
*/
