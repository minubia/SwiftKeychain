//  GenericKey.swift
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

import Foundation

public class GenericKey: PasswordKey {
    
    private var _service:           CFStringRef = ""
    private var _generic:           CFDataRef!
    
    public var service: CFStringRef {
        get {
            return _service
        }
        set {
            _service = newValue
        }
    }
    
    public var generic: CFDataRef {
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
            _service = attributes["service"] as! CFStringRef
        }
        
        if((attributes["generic"]) != nil){
            _generic = attributes["generic"] as! NSData
        }
    }
}