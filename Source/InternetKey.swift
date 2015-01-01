//  InternetKey.swift
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

public class InternetKey: PasswordKey {
    
    var _securityDomain:		CFStringRef!
    var _server:				CFStringRef!
    var _protocol:				CFNumberRef!
    var _authenticationType:	CFNumberRef!
    var _port:					CFNumberRef!
    var _path:					CFStringRef!
    
    var securityDomain: CFStringRef {
        get {
            return _securityDomain
        }
        set {
            _securityDomain = newValue
        }
    }
    
    var server: CFStringRef {
        get {
            return _server
        }
        set {
            _server = newValue
        }
    }
    
    var protocolType: CFNumberRef {
        get {
            return _protocol
        }
        set {
            _protocol = newValue
        }
    }
    
    var authenticationType: CFNumberRef {
        get {
            return _authenticationType
        }
        set {
            _authenticationType = newValue
        }
    }
    
    var port: CFNumberRef {
        get {
            return _port
        }
        set {
            _port = newValue
        }
    }
    
    var path: CFStringRef {
        get {
            return _path
        }
        set {
            _path = newValue
        }
    }
    
    public required override init(attributes: Dictionary<String, Any>) {
        
        super.init(attributes: attributes)
        
        if((attributes["securityDomain"]) is String){
            _securityDomain = attributes["securityDomain"] as CFStringRef
        }
        
        if((attributes["server"]) is String){
            _server = attributes["server"] as CFStringRef
        }
        
        if((attributes["protocol"]) != nil){
            _protocol = attributes["protocol"] as CFNumberRef
        }
        
        if((attributes["authenticationType"]) != nil){
            _authenticationType = attributes["authenticationType"] as CFNumberRef
        }
        
        if((attributes["port"]) != nil){
            _port = attributes["port"] as CFNumberRef
        }
        
        if((attributes["path"]) is String){
            _path = attributes["path"] as CFStringRef
        }
    }
}