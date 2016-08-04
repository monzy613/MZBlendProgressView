# MZBlendProgressView

[![CI Status](http://img.shields.io/travis/monzy613/MZBlendProgressView.svg?style=flat)](https://travis-ci.org/monzy613/MZBlendProgressView)
[![Version](https://img.shields.io/cocoapods/v/MZBlendProgressView.svg?style=flat)](http://cocoapods.org/pods/MZBlendProgressView)
[![License](https://img.shields.io/cocoapods/l/MZBlendProgressView.svg?style=flat)](http://cocoapods.org/pods/MZBlendProgressView)
[![Platform](https://img.shields.io/cocoapods/p/MZBlendProgressView.svg?style=flat)](http://cocoapods.org/pods/MZBlendProgressView)

## Example
```swift
let progressView = MZBlendProgressView(frame: CGRect(x: 0, y: 0, width: 200.0, height: 30.0))
progressView.center = self.view.center
progressView.backgroundColor = .red
progressView.progressLayer.strokeColor = UIColor.black.cgColor

progressView.updateProgress(CGFloat(sender.value))
```

## SnapShot
![img](http://o7b20it1b.bkt.clouddn.com/blendProgressView.png)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MZBlendProgressView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MZBlendProgressView"
```

## Author

monzy613, monzy613@gmail.com

## License

MZBlendProgressView is available under the MIT license. See the LICENSE file for more info.
