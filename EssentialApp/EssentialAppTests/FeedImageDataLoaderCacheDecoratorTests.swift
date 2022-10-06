// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import XCTest
import EssentialFeed

class FeedImageDataLoaderCacheDecorator {
    
    init(loader: FeedImageDataLoader) {}
}

class FeedImageDataLoaderCacheDecoratorTests: XCTestCase {
    
    func test_init_doesNotLoadImageData() {
        let (_, loader) = makeSUT()
        
        XCTAssertTrue(loader.loadedURLs.isEmpty, "Expected no loaded URLs")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedImageDataLoaderCacheDecorator, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = FeedImageDataLoaderCacheDecorator(loader: loader)
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(loader)
        return (sut, loader)
    }
    
    private class LoaderSpy: FeedImageDataLoader {
        private class Task: FeedImageDataLoaderTask {
            func cancel() {}
        }
        
        private(set) var loadedURLs = [URL]()
        
        func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
            return Task()
        }
    }
}
