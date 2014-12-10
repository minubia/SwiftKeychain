[![Stories in Ready](https://badge.waffle.io/minubia/SwiftKeychain.png?label=ready&title=Ready)](https://waffle.io/minubia/SwiftKeychain)
[![Build Status](https://travis-ci.org/minubia/SwiftKeychain.svg?branch=master)](https://travis-ci.org/minubia/SwiftKeychain/)

#Swift Keychain

Swift Keychain is a library written in swift, for Apple's password management system called Keychain

##Table of contents
1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Usage](#usage)
	- [Keys](#keys)
		- [Generic Key](#generic-key)
	- [Add Key](#add-key)
	- [Find Key](#find-key)
	- [Update Key](#update-key)
	- [Delete Key](#delete-key)
4. [UML Diagram](#uml-diagram)
5. [License](#license)
	
## Requirements

- iOS 7.0+
- Xcode 6.1.1

##Installation

We plan on supporting CocoaPods in the future. But at this moment CocoaPods does not support Swift libraries. Until then you can follow these steps to include Swift Keychain in your project

1. You can either clone SwiftKeychain or add it as a git submodule to your project. We recommend the latter.
  * To clone SwiftKeychain simply execute the following command
	`git clone https://github.com/minubia/SwiftKeychain.git`
  * To add SwiftKeychain as a submodule, first make sure you change the shell's current working directory to the root of your project and then execute the following command
	`git submodule add https://github.com/minubia/SwiftKeychain.git`

2. Navigate to the SwiftKeychain folder. Now drag and drop the file `SwiftKeychain.xcodeproj` onto the blue project icon of your project. This icon can be found in the file navigator of Xcode

3. In Xcode, make sure the blue project icon of your project is still selected and select the `Build Phases` tab and expand the `Target Dependencies` group. Click on the `+` sign, select the `SwiftKeychain` target under the `SwiftKeychain` project and click the `Add` button

## Usage
In order to use Swift Keychain, you'll need to import it first
```swift
import SwiftKeychain
```

### Keys
#### Generic Key
Generic Key are used to store simple username/password credentials 
```swift
var attributes: [String: Any] = [
    "username": "admin",
    "password": "demo"
]
let key = GenericKey(attributes: attributes)
```

#####Optional Attributes
######Accessibility
 This value indicates when your app can access the data in a keychain item. The default value for this attribute is `Accessibility.WhenUnlocked`
The following values are allowed:

 - Accessibility.WhenUnlocked
 - Accessibility.AfterFirstUnlock
 - Accessibility.Always
 - Accessibility.WhenPasscodeSetThisDeviceOnly
 - Accessibility.WhenUnlockedThisDeviceOnly
 - Accessibility.AfterFirstUnlockThisDeviceOnly
 - Accessibility.AlwaysThisDeviceOnly

```swift
var attributes: [String: Any] = [
    "accessibility":	Accessibility.WhenUnlocked
]
```
######Service
The service that is associated with the key. By default SwiftKeychain will use your app's bundle ID if this attribute is omitted.
```swift
var attributes: [String: Any] = [
    "service":	NSBundle.mainBundle().bundleIdentifier
]
```
######Access Group 
Access groups can be used to share keychain items among two or more applications. By default no access group will be set meaning only the application that set the keychain item will be able to access it.
```swift
var attributes: [String: Any] = [
    "accessgroup":	"swiftkeychaingroup"
]
```
######Description
A text describing this keychain item.
```swift
var attributes: [String: Any] = [
    "description":	"SwiftKeychain Test Account"
]
```
######Comment
A comment section
```swift
var attributes: [String: Any] = [
    "comment":	"Used for testing purposes"
]
```
######Label
A label for your keychain item
```swift
var attributes: [String: Any] = [
    "label":	"Test Account"
]
```

### Add Key
```swift
var attributes: [String: Any] = [
	"username":			"admin",
	"password":			"demo",
	"accessibility":	Accessibility.WhenUnlocked,
	"service":			NSBundle.mainBundle().bundleIdentifier,
	"accessgroup":		"swiftkeychaingroup",
	"description":		"SwiftKeychain Test Account",
	"comment":			"Used for testing purposes",
	"label":			"Test Account"
]
let key = GenericKey(attributes: attributes)
let resultCode: ResultCode = SwiftKeychain.add(key)
```

### Find Key
```swift
var attributes: [String: Any] = [
	"username": "admin"
]
let key = GenericKey(attributes: attributes)
let result = SwiftKeychain.find(key)
```

### Update Key
```swift
let newPassword = "newpassword"

var attributes: [String: Any] = [
	"username": "admin",
	"password": newPassword
]

let key = GenericKey(attributes: attributes)
let resultCode: ResultCode = SwiftKeychain.update(key)
```

### Delete Key
```swift
var attributes: [String: Any] = [
	"username": "admin"
]

let key = GenericKey(attributes: attributes)
let resultCode: ResultCode = SwiftKeychain.delete(key)
```

## UML Diagram
![UML Diagram](https://cloud.githubusercontent.com/assets/1453745/5264975/78689044-7a3f-11e4-91a8-4706f844eb5c.png)

##License
Copyright © 2014 [Minubia](http://www.minubia.com)

MIT license - [http://www.opensource.org/licenses/mit-license.php](http://www.opensource.org/licenses/mit-license.php)
