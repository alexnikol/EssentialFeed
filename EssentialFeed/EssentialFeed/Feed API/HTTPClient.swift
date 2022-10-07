// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    typealias Result = HTTPClientResult
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to  dispatch to appropriate threads, if needed
    @discardableResult
    func get(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientTask
}
