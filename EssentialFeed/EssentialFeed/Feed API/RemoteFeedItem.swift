// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation

struct RemoteFeedItem: Equatable, Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
