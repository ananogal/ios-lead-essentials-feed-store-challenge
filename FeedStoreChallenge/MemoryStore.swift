//
//  MemoryStore.swift
//  FeedStoreChallenge
//
//  Created by Ana Nogal on 31/03/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public final class MemoryStore: FeedStore {
	private struct Cache {
		let feed: [LocalFeedImage]
		let timestamp: Date
	}

	private var currentCache: Cache? = nil

	public init() { }

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		currentCache = nil
		completion(nil)
	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		currentCache = Cache(feed: feed, timestamp: timestamp)
		completion(nil)
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		if let cache = currentCache {
			completion(.found(feed: cache.feed, timestamp: cache.timestamp))
		} else {
			completion(.empty)
		}
	}
}
