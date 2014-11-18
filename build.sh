#!/bin/sh

BUILD_DIR=`pwd`/build
LATEST_IOS_SDK_VERSION=`xcodebuild -showsdks | grep iphonesimulator | cut -d ' ' -f 4 | ruby -e 'puts STDIN.read.chomp.split("\n").last'`
BUILD_IOS_SDK_VERSION=${SWIFTKEYCHAIN_BUILD_IOS_SDK_VERSION:-$LATEST_IOS_SDK_VERSION}
RUNTIME_IOS_SDK_VERSION=${SWIFTKEYCHAIN_RUNTIME_IOS_SDK_VERSION:-$LATEST_IOS_SDK_VERSION}

set -e

function print_INFO {
    echo "========== INFORMATION =========="
    echo
    echo "   Latest iOS SDK Version: $LATEST_IOS_SDK_VERSION"
    echo "   Building with SDK Version: $BUILD_IOS_SDK_VERSION"
    echo "   Running with SDK Version: $RUNTIME_IOS_SDK_VERSION"
    echo
    echo "================================="
    echo
}

function run_tests {
    osascript -e 'tell app "iOS Simulator" to quit'
    xcodebuild -project SwiftKeychain.xcodeproj -scheme "SwiftKeychain" -configuration "Debug" -sdk "iphonesimulator$BUILD_IOS_SDK_VERSION" -destination "name=iPad Air,OS=$RUNTIME_IOS_SDK_VERSION" build test

    osascript -e 'tell app "iOS Simulator" to quit'
    xcodebuild -project SwiftKeychain.xcodeproj -scheme "SwiftKeychain" -configuration "Debug" -sdk "iphonesimulator$BUILD_IOS_SDK_VERSION" -destination "name=iPhone 5s,OS=$RUNTIME_IOS_SDK_VERSION" build test

    osascript -e 'tell app "iOS Simulator" to quit'
    xcodebuild -project SwiftKeychain.xcodeproj -scheme "SwiftKeychain" -configuration "Debug" -sdk "iphonesimulator$BUILD_IOS_SDK_VERSION" -destination "name=iPhone 6,OS=$RUNTIME_IOS_SDK_VERSION" build test
}

function main {

    print_INFO
    run_tests
}

main $@

