// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation
import EssentialFeed

public class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private let decoratee: FeedImageDataLoader
    private let cache: FeedImageDataCache
    
    public init(decoratee: FeedImageDataLoader, cache: FeedImageDataCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return decoratee.loadImageData(from: url, completion: { [weak self] result in
            switch result {
            case let .success(data):
                self?.cache.save(data, for: url, completion: { _ in })
            default: break
            }
            completion(result)
        })
    }
}
