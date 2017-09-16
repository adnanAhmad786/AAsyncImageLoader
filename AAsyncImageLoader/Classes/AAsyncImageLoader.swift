
import UIKit

/**
 * AAsyncImageLoader is the main entry point for this libray
 * You could use it to load image by hand, and then implements your logic into the `block` provided
 */
public class AAsyncImageLoader {

    /**
     * The UIImage result block you get when you ask for an image
     *
     * - parameters:
     *   - image: Optional, the resulting UIImage or nil if an error occurs
     *   - error: Optional, the last error if anything goes wrong, nil otherwise
     */
    public typealias AAsyncResultBlock = (UIImage?, Error?) -> Void

    // Our custom error domain
    private static let ErrorDomain = "com.citroon.AsyncImageLoaderError"

    // The current task for this instance
    private var task: URLSessionTask?

    // We keep the URL arround, it could be useful (ie. error message)
    private var url: URL?

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
     * *You must call load() to start the request*
     *
     * - parameters:
     *   - url: The url of your image
     *   - block: a block with your image loaded as an UIImage object (or nil if an error occurs) @see AAsyncResultBlock
     * - returns: self to chain
     */
    public func withUrl(url: URL, block: @escaping AAsyncResultBlock) -> Self {
        self.url = url
        task = configuration.urlSession.dataTask(with: url) {
            data, response, error in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let error = error {
                block(nil, error)
            }
            else if let response = response as? HTTPURLResponse{
                if response.statusCode == 200 {
                    if let data = data {
                        block(UIImage(data: data), nil)
                    }
                    else {
                        let errorMessage = "Server Error: data is empty"
                        block(nil, NSError.init(domain: AAsyncImageLoader.ErrorDomain, code: 1, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                    }
                }
                else {
                    let errorMessage = "Server Error: \(response.statusCode) error"
                    block(nil, NSError.init(domain: AAsyncImageLoader.ErrorDomain, code: 2, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                }
            }
            else {
                let errorMessage = "Server Error: the response is unreadable"
                block(nil, NSError.init(domain: AAsyncImageLoader.ErrorDomain, code: 3, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
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
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
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
        task?.cancel()
        return self
    }
}
