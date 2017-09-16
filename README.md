# ![AAsyncImageLoader](logo.png)

[![Version](https://img.shields.io/cocoapods/v/AAsyncImageLoader.svg?style=flat)](http://cocoapods.org/pods/AAsyncImageLoader)
[![License](https://img.shields.io/cocoapods/l/AAsyncImageLoader.svg?style=flat)](http://cocoapods.org/pods/AAsyncImageLoader)
[![Platform](https://img.shields.io/cocoapods/p/AAsyncImageLoader.svg?style=flat)](http://cocoapods.org/pods/AAsyncImageLoader)

*An asynchronous image loader, with some magic including an UIImageView category for drop-in integration.*

This library will allow you to load image from the web to any UIImageView thanks to the UIImageView category.

It is also a more capable low level loading library to get UIImage from the Internet allowing you to control the logic you want to put there.

As from version 1.0.0, this library is written in Swift 3.

## How To Use It

*Requirements*  
This library needs iOS7, nothing else is needed :)  
You can install it from cocoapods (see Installation)  

then `import AAsyncImageLoader`

### The one liner

If you want the drop-in version, it is simple as
 
```swift
imageView.aail_load(NSURL(string: "https://example.com/image.jpg")!, placeholder: UIImage(named: "placeholder_image"))
```

### Reusable Cells

This libray includes some magic, and will work like a charm for your reusable cells.  
It has a cancelation mechanism integrated

```swift
// example from the demo app
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let CellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath)
        
    let name = Array<String>(data.keys)[indexPath.row]
    let imageUrl = data[name]!

    cell.textLabel?.text = name
    cell.imageView?.aail_load(NSURL(string: imageUrl)!, placeholder: UIImage(named: "placeholder_image"))
        
    return cell
}
```

### Keep the control
 
you could also get more control, by using the core of the library to tweak configuration options like caching or also get to cancel the request

```swift
var myImage = UIImage()

let configuration = AAsyncImageLoaderConfiguration()
configuration.defineCachePolicy(.ForceReload)

let aasyncRequest = AAsyncImageLoader(configuration: configuration)
aasyncRequest.withUrl(NSURL(string: "https://example.com/image.jpg")!) {
    image, error in
    if let image = image {
        myImage = image
        // maybe do something with this image
        // don't forget to get back on the main thread
    } else {
        // do something with the error
    }
}
.load() // start the request

// later in the code you can cancel the request if needed
aasyncRequest.cancel()
```

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Testing

This library comes with unit testing, you can start them by checking out this repository into XCode and run it from there

## Installation

### CocoaPods

*The prefered way*

AAsyncImageLoader is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AAsyncImageLoader"
```

### Manual

If needed, you can also copy/past the AAsyncImageLoader* files into your app

## Contributions

AAsyncImageLoader is an open source project. If you'd like to contribute, please submit a pull request.  
But you don't have to write code, you can also:

 - report bug
 - ask questions
 - write more examples or documentation
 - suggest new idea

If you found a bug and are willing to fix it, we will check your Pull Request and integrate it if relevant

## License

AAsyncImageLoader is available under the MIT license. See the LICENSE file for more info.
