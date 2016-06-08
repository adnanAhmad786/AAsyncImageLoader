# ![AAsyncImageLoader](logo.png)

[![Version](https://img.shields.io/cocoapods/v/AAsyncImageLoader.svg?style=flat)](http://cocoapods.org/pods/AAsyncImageLoader)
[![License](https://img.shields.io/cocoapods/l/AAsyncImageLoader.svg?style=flat)](http://cocoapods.org/pods/AAsyncImageLoader)
[![Platform](https://img.shields.io/cocoapods/p/AAsyncImageLoader.svg?style=flat)](http://cocoapods.org/pods/AAsyncImageLoader)

*An asynchronous image loader, with some magic and an UIImageView category for drop-in integration.*

This library will allow you to load image from the web to any UIImageView thanks to the UIImageView category.

It is also a more capable low level loading library to get UIImage from the Internet allowing you to control the logic you want to put there.

## How To Use It

first `import AAsyncImageLoader`, then

### The one liner

If you want the drop-in version, it is simple as
 
```swift
imageView.aail_load(NSURL(string: "https://example.com/image.jpg")!, placeholder: UIImage(named: "placeholder_image"))
```

### Reusable Cells

This libray includes some magic, and will work like a charm for your reusable cells.  
It has a cancelation mechanism integrated

```swift
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

as seen in the demo app

### Keep the control
 
but you could also get more control

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
```

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Testing

This library comes with unit testing, you can start them by checking out this repository into XCode and run it from there

## Requirements

This library needs iOS7, and is best suited for Swift projects
Nothing else is needed :)

## Installation

### CocoaPods

*prefered way*

AAsyncImageLoader is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AAsyncImageLoader"
```

### Manual

You could also copy/past the AAsyncImageLoader* files into your app

## Author

Jérôme Gx  

## License

AAsyncImageLoader is available under the MIT license. See the LICENSE file for more info.
