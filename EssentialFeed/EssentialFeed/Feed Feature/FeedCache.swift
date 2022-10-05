// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation

public protocol FeedCache {
    typealias SaveResult = Error?
    
    func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void)
}
