// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import XCTest
import EssentialFeed

class FeedImageDataLoaderWithFallbackComposite: FeedImageDataLoader {
    let primaryLoader: FeedImageDataLoader
    let fallbackLoader: FeedImageDataLoader
    
    init(primaryLoader: FeedImageDataLoader, fallbackLoader: FeedImageDataLoader) {
        self.primaryLoader = primaryLoader
        self.fallbackLoader = fallbackLoader
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return primaryLoader.loadImageData(from: url, completion: completion)
    }
}

class FeedImageDataLoaderWithFallbackCompositeTests: XCTestCase {
    
    func test_loadImageData_deliversPrimaryImageDataOnPrimarySuccess() {
        let primaryData = Data("primary data".utf8)
        let fallbackData = Data("fallback data".utf8)
        let primaryLoader = LoaderStub(result: .success(primaryData))
        let fallbackLoader = LoaderStub(result: .success(fallbackData))
        let sut = FeedImageDataLoaderWithFallbackComposite(primaryLoader: primaryLoader, fallbackLoader: fallbackLoader)
        let exp = expectation(description: "Wait on load completion")
        
        _ = sut.loadImageData(from: anyURL()) { result in
            switch result {
            case let .success(receivedData):
                XCTAssertEqual(receivedData, primaryData)
                
            default:
                XCTFail("Expected succees with primary data, but got \(result) instead")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    func anyURL() -> URL {
        URL(string: "http://any-url.com")!
    }
    
    private class LoaderStub: FeedImageDataLoader {
        private class LoaderStubTask: FeedImageDataLoaderTask {
            func cancel() {}
        }
        
        let result: FeedImageDataLoader.Result
        
        func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
            completion(result)
            return LoaderStubTask()
        }
        
        init(result: FeedImageDataLoader.Result) {
            self.result = result
        }
    }
}
