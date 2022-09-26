// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation
import EssentialFeed

private func uniqueImage() -> FeedImage {
    return FeedImage(id: UUID(), description: "any", location: "any", imageURL: anyURL())
}

func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedItem]) {
    let models = [uniqueImage(), uniqueImage()]
    let localModels = models.map { LocalFeedItem(id: $0.id, description: $0.description, location: $0.location, url: $0.imageURL) }
    return (models, localModels)
}
