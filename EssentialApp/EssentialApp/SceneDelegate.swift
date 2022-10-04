// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import UIKit
import EssentialFeed
import EssentialFeediOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let httpClient = URLSessionHTTPClient(session: URLSession.shared)
        let url = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/feed")!
        let remoteFeedLoader = RemoteFeedLoader(url: url, client: httpClient)
        let remoteImageDataLoader = RemoteFeedImageDataLoader(client: httpClient)
        let feedViewController = FeedUIComposer.feedComposedWith(
            feedLoader: remoteFeedLoader,
            imageLoader: remoteImageDataLoader
        )
        
        window?.rootViewController = feedViewController
    }
}
