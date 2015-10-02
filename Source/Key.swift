//  Key.swift
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
            switch attributes["accessibility"] as! Accessibility {
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
            }
        }
        
        if((attributes["accessgroup"]) != nil){
            _accessGroup    = attributes["accessgroup"] as! CFStringRef
        }
        
        if((attributes["label"]) != nil){
            _label    = attributes["label"] as! CFStringRef
        }
    }
}
