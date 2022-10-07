// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import UIKit
import EssentialFeed

public protocol FeedImageCellControllerDelegate {
     func didRequestImage()
     func didCancelImageRequest()
 }

public final class FeedImageCellController: FeedImageView {
    private let delegate: FeedImageCellControllerDelegate
    private var cell: FeedImageCell?
    
    public init(delegate: FeedImageCellControllerDelegate) {
        self.delegate = delegate
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        self.cell = tableView.dequeueReusableCell()
        delegate.didRequestImage()
        return cell!
    }
    
    public func display(_ viewModel: FeedImageViewModel<UIImage>) {
        cell?.locationContainer.isHidden = !viewModel.hasLocation
        cell?.locationLabel.text = viewModel.location
        cell?.descriptionLabel.text = viewModel.description
        cell?.feedImageView.setImageAnimated(viewModel.image)
        
        if viewModel.image != nil {
            cell?.feedImageView.alpha = 0
            UIView.animate(withDuration: 0.25, animations: {
                self.cell?.feedImageView.alpha = 1
            })
        }
        
        cell?.feedImageContainer.isShimmering = viewModel.isLoading
        cell?.feedImageRetryButton.isHidden = !viewModel.shouldRetry
        cell?.onRetry = delegate.didRequestImage
    }
    
    func preload() {
        delegate.didRequestImage()
    }

    func cancelLoad() {
        releaseCellForResuse()
        delegate.didCancelImageRequest()
    }
    
    private func releaseCellForResuse() {
        cell = nil
    }
}
