// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    struct UnexpectedValuesRepresentation: Error {}
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data, let httpResponse = response as? HTTPURLResponse {
                completion(.success((data, httpResponse)))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }
        
        task.resume()
        
        return URLSessionTaskWrapper(wrapped: task)
    }
}
