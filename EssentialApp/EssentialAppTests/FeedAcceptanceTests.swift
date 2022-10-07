// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import XCTest
import EssentialFeed
import EssentialFeediOS
@testable import EssentialApp

class FeedAcceptanceTests: XCTestCase {
    
    func test_onLaunch_displaysRemoteFeedWhenCustomerHasConnectivity() {
        let sut = SceneDelegate()
        sut.window = UIWindow()
        sut.configureWindow()
        
        let nav = sut.window?.rootViewController as? UINavigationController
        let feed = nav?.topViewController as! FeedViewController
        
        XCTAssertEqual(feed.numberOfRenderedFeedImageViews(), 2)
        XCTAssertNotNil(feed.simulateFeedImageViewVisible(at: 0)?.renderedImage)
        XCTAssertNotNil(feed.simulateFeedImageViewVisible(at: 1)?.renderedImage)
    }
    
    func test_onLaunch_displaysCachedRemoteFeedWhenCustomerHasNoConnectivity() {}
    
    func test_onLaunch_displaysEmptyFeedWhenCustomerHasNoConnectivityAndNoCache() {}
}
