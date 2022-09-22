// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import XCTest

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.get(from: URL(string: "http://a-url.com")!)
    }
}

class HTTPClient {
    static var shared = HTTPClient()
    
    private init() {}
    
    var requestedURL: URL?
    
    func get(from url: URL) {
        self.requestedURL = url
    }
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNoRequestDataFromURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
