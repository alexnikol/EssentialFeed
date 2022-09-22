// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Error)
}
