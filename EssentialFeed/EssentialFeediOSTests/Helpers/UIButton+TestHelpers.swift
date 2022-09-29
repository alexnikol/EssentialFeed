// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
