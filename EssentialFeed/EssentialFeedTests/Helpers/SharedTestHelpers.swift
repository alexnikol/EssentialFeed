// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import Foundation

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    Data()
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}
