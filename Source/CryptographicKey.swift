//  CryptographicKey.swift
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

public class CryptographicKey: Key {
    
    //Not sure about this. The Apple documentation lists kSecAttrKeyClass as CFTypeRef
    //We are using CFStringRef for now
    var _keyClass:			CFStringRef!
    var _applicationLabel:	CFStringRef!
    var _isPermanent:		CFBooleanRef!
    var _applicationTag:	CFDataRef!
    var _keyType:			CFNumberRef!
    var _keySizeInBits:		CFNumberRef!
    var _effectiveKeySize:	CFNumberRef!
    var _canEncrypt:		CFBooleanRef!
    var _canDecrypt:		CFBooleanRef!
    var _canDerive:			CFBooleanRef!
    var _canSign:			CFBooleanRef!
    var _canVerify:			CFBooleanRef!
    var _canWrap:			CFBooleanRef!
    var _canUnwrap:			CFBooleanRef!
    
    var keyClass: CFStringRef {
        get {
            return _keyClass
        }
        set {
            _keyClass = newValue
        }
    }
    
    var applicationLabel: CFStringRef {
        get {
            return _applicationLabel
        }
        set {
            _applicationLabel = newValue
        }
    }
    
    var isPermanent: CFBooleanRef {
        get {
            return _isPermanent
        }
        set {
            _isPermanent = newValue
        }
    }
    
    var applicationTag: CFDataRef {
        get {
            return _applicationTag
        }
        set {
            _applicationTag = newValue
        }
    }
    
    var keyType: CFNumberRef {
        get {
            return _keyType
        }
        set {
            _keyType = newValue
        }
    }
    
    var keySizeInBits: CFNumberRef {
        get {
            return _keySizeInBits
        }
        set {
            _keySizeInBits = newValue
        }
    }
    
    var effectiveKeySize: CFNumberRef {
        get {
            return _effectiveKeySize
        }
        set {
            _effectiveKeySize = newValue
        }
    }
    
    var canEncrypt: CFBooleanRef {
        get {
            return _canEncrypt
        }
        set {
            _canEncrypt = newValue
        }
    }
    
    var canDecrypt: CFBooleanRef {
        get {
            return _canDecrypt
        }
        set {
            _canDecrypt = newValue
        }
    }
    
    var canDerive: CFBooleanRef {
        get {
            return _canDerive
        }
        set {
            _canDerive = newValue
        }
    }
    
    var canSign: CFBooleanRef {
        get {
            return _canSign
        }
        set {
            _canSign = newValue
        }
    }
    
    var canVerify: CFBooleanRef {
        get {
            return _canVerify
        }
        set {
            _canVerify = newValue
        }
    }
    
    var canWrap: CFBooleanRef {
        get {
            return _canWrap
        }
        set {
            _canWrap = newValue
        }
    }
    
    var canUnwrap: CFBooleanRef {
        get {
            return _canUnwrap
        }
        set {
            _canUnwrap = newValue
        }
    }
    
    public required override init(attributes: Dictionary<String, Any>) {
        
        super.init(attributes: attributes)

        if((attributes["keyClass"]) is String){
            _keyClass = attributes["keyClass"] as CFStringRef
        }
        
        if((attributes["applicationLabel"]) is String){
            _applicationLabel = attributes["applicationLabel"] as CFStringRef
        }
        
        if((attributes["isPermanent"]) != nil){
            _isPermanent = attributes["isPermanent"] as CFBooleanRef
        }
        
        if((attributes["applicationTag"]) != nil){
            _applicationTag = attributes["applicationTag"] as NSData
        }
        
        if((attributes["keyType"]) != nil){
            _keyType = attributes["keyType"] as CFNumberRef
        }
        
        if((attributes["keySizeInBits"]) != nil){
            _keySizeInBits = attributes["keySizeInBits"] as CFNumberRef
        }
        
        if((attributes["effectiveKeySize"]) != nil){
            _effectiveKeySize = attributes["effectiveKeySize"] as CFNumberRef
        }
        
        if((attributes["canEncrypt"]) != nil){
            _canEncrypt = attributes["canEncrypt"] as CFBooleanRef
        }
        
        if((attributes["canDecrypt"]) != nil){
            _canDecrypt = attributes["canDecrypt"] as CFBooleanRef
        }
        
        if((attributes["canDerive"]) != nil){
            _canDerive = attributes["canDerive"] as CFBooleanRef
        }
        
        if((attributes["canSign"]) != nil){
            _canSign = attributes["canSign"] as CFBooleanRef
        }
        
        if((attributes["canVerify"]) != nil){
            _canVerify = attributes["canVerify"] as CFBooleanRef
        }
        
        if((attributes["canWrap"]) != nil){
            _canWrap = attributes["canWrap"] as CFBooleanRef
        }
        
        if((attributes["canUnwrap"]) != nil){
            _canUnwrap = attributes["canUnwrap"] as CFBooleanRef
        }
    }
}