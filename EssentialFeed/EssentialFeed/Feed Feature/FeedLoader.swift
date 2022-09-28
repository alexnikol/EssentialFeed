// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
