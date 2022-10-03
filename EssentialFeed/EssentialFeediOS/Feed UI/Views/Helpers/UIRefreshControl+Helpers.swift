// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
