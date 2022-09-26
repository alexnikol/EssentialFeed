// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ feed: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
}
