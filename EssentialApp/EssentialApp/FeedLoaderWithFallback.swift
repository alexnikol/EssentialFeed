// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation
import EssentialFeed

public class FeedLoaderWithFallbackComposite: FeedLoader {
    private let primaryLoader: FeedLoader
    private let fallbackLoader: FeedLoader
    
    public init(primaryLoader: FeedLoader, fallbackLoader: FeedLoader) {
        self.primaryLoader = primaryLoader
        self.fallbackLoader = fallbackLoader
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        primaryLoader.load { [weak self] result in
            
            switch result {
            case .success:
                completion(result)
                
            case .failure:
                self?.fallbackLoader.load { result in
                    completion(result)
                }
            }
        }
    }
}
