// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to  dispatch to appropriate threads, if needed
    func get(from url: URL, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}
