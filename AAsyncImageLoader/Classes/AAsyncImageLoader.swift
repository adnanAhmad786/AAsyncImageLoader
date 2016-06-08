
import UIKit

/**
 * AAsyncImageLoader is the main entry point for this libray
 * You should use it to load image by hand, and then implements your logic into the `block` provided
 */
public class AAsyncImageLoader {

    /**
     * The UIImage result block you get when you ask for an image
     *
     * - parameters:
     *   - image: Optionnal, the resulting UIImage or nil if an error occurs
     *   - error: Optionnal, the last error if anything goes wrong, nil otherwise
     */
    public typealias AAsyncResultBlock = (image: UIImage?, error: NSError?) -> Void

    // Our custom error domain
    private static let ErrorDomain = "com.citroon.AsyncImageLoaderError"

    // The current task for this instance
    private var task: NSURLSessionTask?

    // We keep the URL arround, it could be useful (ie. error message)
    private var url: NSURL?

    // The AAsyncImageLoaderConfiguration
    private var configuration: AAsyncImageLoaderConfiguration

    /**
     * Create a new instance
     * This is the *designated* initializer
     *
     * - parameters:
     *   - configuration: Default or customized instance of AAsyncImageLoaderConfiguration
     */
    public init(configuration: AAsyncImageLoaderConfiguration) {
        self.configuration = configuration
    }

    /**
     * Set the URL you want to load and set the result `block` that will be executed
     * *You should call load() to start the request*
     *
     * - parameters:
     *   - url: The url of your image
     *   - block: a block with your image loaded as an UIImage object (or nil if an error occurs) @see AAsyncResultBlock
     * - returns: self to chain
     */
    public func withUrl(url: NSURL, block: AAsyncResultBlock) -> Self {
        print("load with url: \(url)")
        self.url = url
        task = configuration.urlSession.dataTaskWithURL(url) {
            data, response, error in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            print("url loaded: \(url)")
            if let error = error {
                block(image: nil, error: error)
            }
            else if let response = response as? NSHTTPURLResponse{
                if response.statusCode == 200 {
                    if let data = data {
                        block(image: UIImage(data: data), error: nil)
                    }
                    else {
                        let errorMessage = "Server Error: data is empty"
                        block(image: nil, error: NSError(domain: AAsyncImageLoader.ErrorDomain, code: 1, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                    }
                }
                else {
                    let errorMessage = "Server Error: \(response.statusCode) error"
                    block(image: nil, error: NSError(domain: AAsyncImageLoader.ErrorDomain, code: 2, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                }
            }
            else {
                let errorMessage = "Server Error: the response is unreadable"
                block(image: nil, error: NSError(domain: AAsyncImageLoader.ErrorDomain, code: 3, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
            }
        }

        return self
    }

    /**
     * Fetch the image
     *
     * - parameters: none
     * - returns: self to chain
     */
    public func load() -> Self {
        print("load")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        task?.resume()
        return self
    }

    /**
     * Cancel the current request
     *
     * - parameters: none
     * - returns: self to chain
     */
    public func cancel() -> Self {
        print("canceled request \(self.url)")
        task?.cancel()
        return self
    }
}
