
import UIKit

// We need a stable id for objc_*AssociatedObject functions
// so we will use this const memory address
var _AAsyncImageLoaderAssociatedObjectHandle: Int = 0

/**
 * UIImageView extension to wrap up the AAsyncImageLoader library
 *
 * Usage: 
 * `myImageView.aail_urlLoad(url)`
 */
public extension UIImageView {

    // Computed var to set/get the current request for this UIImageView instance as an associated object
    private var _aail_request: AAsyncImageLoader? {
        get {
            return objc_getAssociatedObject(self, &_AAsyncImageLoaderAssociatedObjectHandle) as? AAsyncImageLoader
        }
        set {
            objc_setAssociatedObject(self, &_AAsyncImageLoaderAssociatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /**
     * Load the URL in this UIImageView
     *
     * This will cancel any previous request pending on this view
     *
     * - parameters:
     *   - url: The url of your image
     *   - placeholder: Optional, the image (UImage instance) to show while the request is not fullfiled
     *   - statusBlock: Optional, a block with your image loaded as an UIImage object (or nil if an error occurs) @see AAsyncResultBlock
     * - returns: nothing
     */
    func aail_load(url: URL, placeholder: UIImage? = nil, statusBlock: AAsyncImageLoader.AAsyncResultBlock? = nil) {
        if let placeholder = placeholder {
            self.image = placeholder
        }

        aail_cancel()
        _aail_request = AAsyncImageLoader(configuration: AAsyncImageLoaderConfiguration())
            .withUrl(url: url) {
                image, error in

                if let image = image {
                    DispatchQueue.main.async() {
                        self.image = image
                    }
                }

                statusBlock?(image, error)
            }
            .load()
    }

    /**
     * Cancel the request associated to this UIImageView (if any)
     *
     * - parameters: none
     * - returns: nothing
     */
    func aail_cancel() {
        _ = _aail_request?.cancel()
    }
}
