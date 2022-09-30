// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import XCTest

class FeedPresenter {
    init(view: Any) {}
}

class FeedPresenterTests: XCTestCase {
    
    func test_init_doesNotSendMessagesToView() {
        let view = ViewSpy()
        
        _ = FeedPresenter(view: view)
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    private class ViewSpy {
        let messages = [Any]()
    }
}
