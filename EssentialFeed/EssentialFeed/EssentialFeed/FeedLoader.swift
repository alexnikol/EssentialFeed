//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Alexander Nikolaychuk on 22.09.2022.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Error)
}
