// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import XCTest

final class FeedViewController {
    
    init(loader: FeedViewControllerTests.LoaderSpy) {}
}

final class FeedViewControllerTests: XCTestCase {
    
    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        _ = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }
    
    // MARK: - LoaderSpy
    
    class LoaderSpy {
        private(set) var loadCallCount = 0
    }
}
