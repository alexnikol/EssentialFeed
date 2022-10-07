// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
