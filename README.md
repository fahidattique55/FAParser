# FAParser

[![CI Status](http://img.shields.io/travis/Fahid Attique/FAParser.svg?style=flat)](https://travis-ci.org/Fahid Attique/FAParser)
[![Version](https://img.shields.io/cocoapods/v/FAParser.svg?style=flat)](http://cocoapods.org/pods/FAParser)
[![License](https://img.shields.io/cocoapods/l/FAParser.svg?style=flat)](http://cocoapods.org/pods/FAParser)
[![Platform](https://img.shields.io/cocoapods/p/FAParser.svg?style=flat)](http://cocoapods.org/pods/FAParser)


## Platform

Swift 3.1


## Features

* You can parse JSON using Apple's Key value coding technique with minimum lines of code.
* You can archive & unarchive your custom object in User Defaults with minimum lines of code.


## Usage

### JSON Parsing with Key Value Coding

* Add the following code in your modal class.

```swift

import FAParser

override init() {
    super.init()
}

// MARK: KVC

override func setValue(_ value: Any?, forKey key: String) {

    if let aVlaue = value {

        if key == "JSON Object Key" {
            customObject = <Custom Object Class Name>.objectfrom(json: value)
        }
        else if key == "JSON Array Key" {
            customObjectsArray = <Custom Object Class Name>.objectsfrom(jsonArray: value as! Array)
        }
    else{
            super.setValue(aVlaue, forKey: key)
        }
    }
}

override func setValue(_ value: Any?, forUndefinedKey key: String) {
    print("This class is not key-value-compliant for key: \(key) & value : \(value)")
}

```


### Archiving & Unarchiving

* Add the following code in your modal class.

```swift

import FAParser

//  Subclass your Custom Modal Class with FAAutoCode Class 

class <Custom Object Class Name>: FAAutoCode

 
// MARK: NSCoding

required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}

```

* All Done ! FAAutoCode Class will automatically write the NSCoding protocols code for your Custom Modal Classes 




## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```


To integrate FAParser into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'FAParser'
end
```

Then, run the following command:

```bash
$ pod install
```


## License

FAParser is available under the MIT license. See the LICENSE file for more info.


## Author

**Fahid Attique** - (https://github.com/fahidattique55)

