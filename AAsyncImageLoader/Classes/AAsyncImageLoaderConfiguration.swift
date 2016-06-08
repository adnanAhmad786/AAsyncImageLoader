
import Foundation

/**
 * AAsyncImageLoaderConfiguration allows you to get more fined control over the library
 * The defaults works pretty well
 */
public class AAsyncImageLoaderConfiguration {

    /**
     * CachePolicy is used to change the caching behaviour
     *
     * These can be seen as aliases for NSURLRequest cachePolicy
     *
     * - UseServerPolicy: *default* use the caching information provided by the server
     * - ForceReload: bypass the caching information and makes a new full request
     * - ForceCacheThenNetwork: bypass the caching information and use cached data is available, otherwise go through the network
     */
    public enum CachePolicy {
        case UseServerPolicy // default
        case ForceReload
        case ForceCacheThenNetwork
    }

    /**
     * WIP (remove)
     */
    public enum CancelRequestPolicy {
        case None // The user is in charge
        case BestEffort // Check for parent
        case Agressive // Check for parent and bubble up to verify
    }

    private var cancelPolicy: CancelRequestPolicy = .None
    private var cachePolicy: NSURLRequestCachePolicy = .UseProtocolCachePolicy

    // Lazy instanciate the main NSURLSession object so we can integrate our custom NSURLSessionConfiguration object
    internal lazy var urlSession: NSURLSession = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.requestCachePolicy = self.cachePolicy
        return NSURLSession(configuration: configuration)
    }()

    public init() { }

    /**
     * Choose the caching policy (@see CachePolicy)
     *
     * - parameters:
     *   - cachePolicy: A CachePolicy enum value
     * - returns: self to chain options
     */
    public func defineCachePolicy(cachePolicy: CachePolicy) -> Self {
        switch cachePolicy {
        case .ForceReload:
            self.cachePolicy = .ReloadIgnoringLocalCacheData
        case .ForceCacheThenNetwork:
            self.cachePolicy = .ReturnCacheDataElseLoad
        default:
            self.cachePolicy = .UseProtocolCachePolicy
        }
        return self
    }

    // TODO remove
    public func defineCancelRequestPolicy(cancelPolicy: CancelRequestPolicy) -> Self {
        self.cancelPolicy = cancelPolicy
        return self
    }

    // Cleanup after ourself
    deinit {
        urlSession.invalidateAndCancel()
    }
    
}

