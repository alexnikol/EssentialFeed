// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation
import EssentialFeed
import EssentialFeediOS
import Combine

final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
    private let feedLoader: () -> FeedLoader.Publisher
    private var cancellable: Cancellable?
    var presenter: FeedPresenter?
    
    init(feedLoader: @escaping () -> FeedLoader.Publisher) {
        self.feedLoader = feedLoader
    }
    
    func loadFeed() {
        presenter?.didStartLoadingFeed()
        
        cancellable = feedLoader().sink(
            receiveCompletion: {  [weak self] completion in
                switch completion {
                case .finished: break
                    
                case let .failure(error):
                    self?.presenter?.didFinishLoadingFeed(with: error)
                }
            },
            receiveValue: { [weak self] feed in
                self?.presenter?.didFinishLoadingFeed(with: feed)
            }
        )
    }
    
    func didRequestFeedRefresh() {
        loadFeed()
    }
}
