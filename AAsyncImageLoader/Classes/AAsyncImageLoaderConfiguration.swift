
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
     * - ForceReload: bypass the caching information and fire a new request every time
     * - ForceCacheThenNetwork: bypass the caching information and use cached data is available, otherwise use the network
     */
    public enum CachePolicy {
        case UseServerPolicy // default
        case ForceReload
        case ForceCacheThenNetwork
    }

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

    // Cleanup after ourself
    deinit {
        urlSession.invalidateAndCancel()
    }
}
