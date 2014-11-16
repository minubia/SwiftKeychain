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

protocol Key {
    
    var accessibility: Accessibility { get set }
    var accessGroup: CFStringRef { get set }
    init(attributes: Dictionary<String, Any>)
}

public struct GenericKey: Key {
    
    var accessibility: Accessibility {
        get {
            return self.accessibility
        }
        set(newValue) {
            self.accessibility = newValue
        }
    }
    
    var accessGroup: CFStringRef {
        get {
            return self.accessGroup
        }
        set(newValue) {
            self.accessGroup = newValue
        }
    }
    
    var creationDate: CFDateRef {
        get {
            return self.creationDate
        }
    }
    
    var modificationDate: CFDateRef {
        get {
            return self.modificationDate
        }
    }
    
    var description: CFStringRef {
        get {
            return self.description
        }
        set(newValue) {
            self.description = newValue
        }
    }
    
    var comment: CFStringRef {
        get {
            return self.comment
        }
        set(newValue) {
            self.comment = newValue
        }
    }
    
    var creator: CFNumberRef {
        get {
            return self.creator
        }
        set(newValue) {
            self.creator = newValue
        }
    }
    
    var type: CFNumberRef {
        get {
            return self.type
        }
        set(newValue) {
            self.type = newValue
        }
    }
    
    var label: CFStringRef {
        get {
            return self.label
        }
        set(newValue) {
            self.label = newValue
        }
    }
    
    var isInvisible: CFBooleanRef {
        get {
            return self.isInvisible
        }
        set(newValue) {
            self.isInvisible = newValue
        }
    }
    
    var isNegative: CFBooleanRef {
        get {
            return self.isNegative
        }
        set(newValue) {
            self.isNegative = newValue
        }
    }
    
    var account: CFStringRef {
        get {
            return self.account
        }
        set(newValue) {
            self.account = newValue
        }
    }
    
    var service: CFStringRef {
        get {
            return self.service
        }
        set(newValue) {
            self.service = newValue
        }
    }
    
    var generic: CFDataRef {
        get {
            return self.generic
        }
        set(newValue) {
            self.generic = newValue
        }
    }
    
    public init(attributes: Dictionary<String, Any>) {
        accessibility   = .WhenUnlocked
        isInvisible     = kCFBooleanFalse
    }
    
    /*
    kSecAttrAccessible
    kSecAttrAccessGroup
    kSecAttrCreationDate
    kSecAttrModificationDate
    kSecAttrDescription
    kSecAttrComment
    kSecAttrCreator
    kSecAttrType
    kSecAttrLabel
    kSecAttrIsInvisible
    kSecAttrIsNegative
    kSecAttrAccount
    kSecAttrService
    kSecAttrGeneric
    */
}


public struct InternetKey: Key {
    
    var accessibility: Accessibility {
        get {
            return self.accessibility
        }
        set(newValue) {
            self.accessibility = newValue
        }
    }
    
    var accessGroup: CFStringRef {
        get {
            return self.accessGroup
        }
        set(newValue) {
            self.accessGroup = newValue
        }
    }
    
    public init(attributes: Dictionary<String, Any>) {
        accessibility   = .WhenUnlocked
        //isInvisible     = kCFBooleanFalse
    }
}

/*
struct Certificate: Key {
}

struct PrivateKey: Key {
}

struct Identity: Key {
}
*/