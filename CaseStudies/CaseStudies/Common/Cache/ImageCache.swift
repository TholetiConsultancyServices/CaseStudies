//
//  ImageCache.swift
//  CaseStudies
//
//  Created by Appaji Tholeti on 26/01/2021.
//

import Foundation

protocol UrlDataChacheable {
    func cachedImageData(for request: URLRequest) -> Data?
    func storeImageData( data: Data?, request: URLRequest, response: URLResponse?)
}

struct ImageCache: UrlDataChacheable {

    private let cache: URLCache

    init(cache: URLCache = URLCache.shared) {
        self.cache = cache
    }

    func cachedImageData(for request: URLRequest) -> Data? {
        guard let cached = cache.cachedResponse(for: request)  else { return nil }
        return cached.data
    }

    func storeImageData( data: Data?, request: URLRequest, response: URLResponse?) {
        guard let imageData = data, let urlResponse = response else {
            return
        }

        let cachedResponse = CachedURLResponse(response: urlResponse, data: imageData)
        self.cache.storeCachedResponse(cachedResponse, for: request)
    }
}
