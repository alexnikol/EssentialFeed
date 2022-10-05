// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation
import EssentialFeed

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func uniqueFeed() -> [FeedImage] {
    return [uniqueImage(), uniqueImage(), uniqueImage()]
}

func uniqueImage() -> FeedImage {
    return FeedImage(id: UUID(), description: "any", location: "any", imageURL: URL(string: "https://any-feed-image-url.com")!)
}
