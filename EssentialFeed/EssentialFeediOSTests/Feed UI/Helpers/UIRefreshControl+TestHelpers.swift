// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}
