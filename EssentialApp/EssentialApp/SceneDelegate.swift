// Copyright © 2022 Oleksandr Nikolaichuk. All rights reserved.

import UIKit
import EssentialFeed
import EssentialFeediOS
import CoreData
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private var remoteFeedLoader: RemoteFeedLoader?
    
    private lazy var store: FeedStore & FeedImageDataStore = {
        try! CoreDataFeedStore(
            storeURL: NSPersistentContainer
                .defaultDirectoryURL()
                .appendingPathComponent("feed-store.sqlite"))
    }()
    
    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store, currentDate: Date.init)
    }()
    
    convenience init(httpClient: HTTPClient, store: FeedStore & FeedImageDataStore) {
        self.init()
        self.httpClient = httpClient
        self.store = store
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        let feedViewController = FeedUIComposer.feedComposedWith(
            feedLoader: makeRemoteFeedLoaderWithLocalFallback,
            imageLoader: makeLocalFeedImageDataLoaderWithRemoteFallback
        )
        window?.rootViewController = UINavigationController(rootViewController: feedViewController)
        window?.makeKeyAndVisible()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        localFeedLoader.validateCache { _ in }
    }
    
    private func makeRemoteFeedLoaderWithLocalFallback() -> FeedLoader.Publisher {
        let remoteURL = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/feed")!
        let remoteFeedLoader = RemoteFeedLoader(url: remoteURL, client: httpClient)
        self.remoteFeedLoader = remoteFeedLoader
        return remoteFeedLoader
            .loaderPublisher()
            .caching(to: localFeedLoader)
            .fallback(to: localFeedLoader.loaderPublisher)
    }
    
    private func makeLocalFeedImageDataLoaderWithRemoteFallback(from url: URL) -> FeedImageDataLoader.Publisher {
        let remoteImageDataLoader = RemoteFeedImageDataLoader(client: httpClient)
        let localImageDataLoader = LocalFeedImageDataLoader(store: store)
        return localImageDataLoader
            .loadImageDataPublisher(from: url)
            .fallback(to: {
                remoteImageDataLoader
                    .loadImageDataPublisher(from: url)
                    .caching(to: localImageDataLoader, for: url)
            })
    }
}
