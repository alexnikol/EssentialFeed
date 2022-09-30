// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import UIKit

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

final class FeedRefreshViewController: NSObject {
    @IBOutlet private(set) var view: UIRefreshControl?
    var delegate: FeedRefreshViewControllerDelegate?

    
    @objc
    @IBAction func refresh() {
        delegate?.didRequestFeedRefresh()
    }
}

extension FeedRefreshViewController: FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
}
