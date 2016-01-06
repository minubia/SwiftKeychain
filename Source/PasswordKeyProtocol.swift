//  PasswordKeyProtocol.swift
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

protocol PasswordKeyProtocol: KeyProtocol {
    
    var account:            CFStringRef     { get set }
    var isNegative:         CFBooleanRef    { get set }
    var description:        CFStringRef     { get set }
    var comment:            CFStringRef     { get set }
    var creator:            CFNumberRef     { get set }
    var type:               CFNumberRef     { get set }
    var isInvisible:        CFBooleanRef    { get set }
    var creationDate:       CFDateRef       { get }
    var modificationDate:   CFDateRef       { get }
    
    var password:           NSString        { get set }
}
