#SwiftKeychain

SwiftKeychain is a library written in swift, for Apple's password management system called Keychain

##Table of contents
1. [Requirements](#requirements)
1. [Installation](#installation)
1. [Usage](#usage)
	- [Generic Key](#generic-key)
	
## Requirements

- iOS 7.0+
- Xcode 6.1

##Installation

We plan on supporting CocoaPods in the future. But at this moment CocoaPods does not support Swift libraries. Until then you can follow these steps to install this library in your project

1. You can either clone SwiftKeychain or add it as a git submodule to your project. We recommend the latter.
  * To clone SwiftKeychain simply execute the following command
	`git clone https://github.com/minubia/SwiftKeychain.git`
  * To add SwiftKeychain as a submodule, first make sure you change the shell's current working directory to the root of your project. Now execute the following command
	`git submodule add https://github.com/minubia/SwiftKeychain.git`

2. Navigate to the SwiftKeychain folder. Now drag and drop the file `SwiftKeychain.xcodeproj` onto the blue project icon of your project. This icon can be found in the file navigator of Xcode

3. In Xcode, make sure the blue project icon of your project is still selected and select the `Build Phases` tab and expand the `Target Dependencies` group. Click on the `+` sign, select the `SwiftKeychain` target under the `SwiftKeychain` project and click the `Add` button

## Usage
In order to use SwiftKeychain, you'll need to import it first
```swift
import SwiftKeychain
```

### Generic Key
Generic Key are used to store simple username/password credentials 
```swift
var attributes: [String: Any] = [
    "username": "admin",
    "password": "demo"
]
let key = GenericKey(attributes: attributes)
```
#### Add Key
```swift
let resultCode: ResultCode = SwiftKeychain.add(key)
```

#### Update Key
Not yet available

#### Delete Key
Not yet available
