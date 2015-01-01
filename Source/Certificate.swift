//  Certificate.swift
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

public class Certificate: Key {
    
    var _subject:				CFDataRef!
    var _issuer:				CFDataRef!
    var _serialNumber:			CFDataRef!
    var _subjectKeyID:			CFDataRef!
    var _publicKeyHash:			CFDataRef!
    var _certificateType:		CFNumberRef!
    var _certificateEncoding:	CFNumberRef!
    
    var subject: CFDataRef {
        get {
            return _subject
        }
    }
    
    var issuer: CFDataRef {
        get {
            return _issuer
        }
    }
    
    var serialNumber: CFDataRef {
        get {
            return _serialNumber
        }
    }
    
    var subjectKeyID: CFDataRef {
        get {
            return _subjectKeyID
        }
    }
    
    var publicKeyHash: CFDataRef {
        get {
            return _publicKeyHash
        }
    }
    
    var certificateType: CFNumberRef {
        get {
            return _certificateType
        }
    }
    
    var certificateEncoding: CFNumberRef {
        get {
            return _certificateEncoding
        }
    }
    
    public required override init(attributes: Dictionary<String, Any>) {
        
        super.init(attributes: attributes)
        
        if((attributes["subject"]) != nil){
            _subject = attributes["subject"] as NSData
        }
        
        if((attributes["issuer"]) != nil){
            _issuer = attributes["issuer"] as NSData
        }
        
        if((attributes["serialNumber"]) != nil){
            _serialNumber = attributes["serialNumber"] as NSData
        }
        
        if((attributes["subjectKeyID"]) != nil){
            _subjectKeyID = attributes["subjectKeyID"] as NSData
        }
        
        if((attributes["publicKeyHash"]) != nil){
            _publicKeyHash = attributes["publicKeyHash"] as NSData
        }
        
        if((attributes["certificateType"]) != nil){
            _certificateType = attributes["certificateType"] as CFNumberRef
        }
        
        if((attributes["certificateEncoding"]) != nil){
            _certificateEncoding = attributes["certificateEncoding"] as CFNumberRef
        }
    }
}