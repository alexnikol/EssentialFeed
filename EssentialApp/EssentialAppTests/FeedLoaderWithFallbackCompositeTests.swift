// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import XCTest
import EssentialFeed

class FeedLoaderWithFallback: FeedLoader {
    private let primaryLoader: FeedLoader
    private let fallbackLoader: FeedLoader
    
    init(primaryLoader: FeedLoader, fallbackLoader: FeedLoader) {
        self.primaryLoader = primaryLoader
        self.fallbackLoader = fallbackLoader
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        primaryLoader.load { [weak self] result in
            
            switch result {
            case .success:
                completion(result)
                
            case .failure:
                self?.fallbackLoader.load { result in
                    completion(result)
                }
            }
        }
    }
}

class FeedLoaderWithFallbackCompositeTests: XCTestCase {
    
    func test_load_deliversPrimaryFeedOnPrimarySuccess() {
        let primaryFeed = uniqueFeed()
        let fallbackFeed = uniqueFeed()
        let sut = makeSUT(primaryResult: .success(primaryFeed), fallbackResult: .success(fallbackFeed))
        
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case let .success(receivedFeed):
                XCTAssertEqual(receivedFeed, primaryFeed)
                exp.fulfill()
            case .failure:
                XCTFail("Expected successful load feed result, got \(result) instead")
            }
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_load_deliversFallbackFeedOnPrimaryFailure() {
        let fallbackFeed = uniqueFeed()
        let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .success(fallbackFeed))
        
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case let .success(receivedFeed):
                XCTAssertEqual(receivedFeed, fallbackFeed)
                exp.fulfill()
            case .failure:
                XCTFail("Expected successful load feed result, got \(result) instead")
            }
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(primaryResult: FeedLoader.Result,
                         fallbackResult: FeedLoader.Result,
                         file: StaticString = #file,
                         line: UInt = #line) -> FeedLoaderWithFallback {
        let primaryLoader = LoaderStub(result: primaryResult)
        let fallbackLoader = LoaderStub(result: fallbackResult)
        let sut = FeedLoaderWithFallback(primaryLoader: primaryLoader, fallbackLoader: fallbackLoader)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(primaryLoader, file: file, line: line)
        trackForMemoryLeaks(fallbackLoader, file: file, line: line)
        return sut
    }
    
    private class LoaderStub: FeedLoader {
        private let result: FeedLoader.Result
        
        init(result: FeedLoader.Result) {
            self.result = result
        }
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            completion(result)
        }
    }
    
    private func uniqueFeed() -> [FeedImage] {
        return [uniqueImage(), uniqueImage(), uniqueImage()]
    }
    
    private func uniqueImage() -> FeedImage {
        return FeedImage(id: UUID(), description: "any", location: "any", imageURL: URL(string: "https://any-feed-image-url.com")!)
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
