//  PasswordKey.swift
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

public class PasswordKey: Key, PasswordKeyProtocol {
    
    private var _creationDate:      CFDateRef!
    private var _modificationDate:  CFDateRef!
    private var _description:       CFStringRef = ""
    private var _comment:           CFStringRef = ""
    private var _creator:           CFNumberRef!
    private var _account:           CFStringRef!
    private var _isInvisible:       CFBooleanRef!
    private var _isNegative:        CFBooleanRef = false
    private var _type:              CFNumberRef!
    
    private var _password:          NSData!
    
    public var creationDate: CFDateRef {
        get {
            return _creationDate
        }
    }
    
    public var modificationDate: CFDateRef {
        get {
            return _modificationDate
        }
    }
    
    public var description: CFStringRef {
        get {
            return _description
        }
        set {
            _description = newValue
        }
    }
    
    public var comment: CFStringRef {
        get {
            return _comment
        }
        set {
            _comment = newValue
        }
    }
    
    public var creator: CFNumberRef {
        get {
            return _creator
        }
        set {
            _creator = newValue
        }
    }
    
    public var account: CFStringRef {
        get {
            return _account
        }
        set {
            _account = newValue
        }
    }
    
    public var isInvisible: CFBooleanRef {
        get {
            return _isInvisible
        }
        set {
            _isInvisible = newValue
        }
    }
    
    public var isNegative: CFBooleanRef {
        get {
            return _isNegative
        }
        set {
            _isNegative = newValue
        }
    }
    
    public var type: CFNumberRef {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
    
    public var password: NSString {
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
        if((attributes["description"]) != nil){
            description    = attributes["description"] as String
        }
        if((attributes["comment"]) != nil){
            comment    = attributes["comment"] as String
        }
        if((attributes["isNegative"]) != nil){
            isNegative    = attributes["isNegative"] as CFBooleanRef
        }
    }
}
