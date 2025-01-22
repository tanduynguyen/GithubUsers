//
//  NetworkManager.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 20/1/25.
//

import Foundation
import os

/// This is our network class, it will handle all our requests
class NetworkManager {
    
    private let urlSession: URLSession
    private let logger = Logger(subsystem: "com.duynguyen.GithubUsers", category: "NetworkManager")
    
    private static let defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.urlCache = URLCache(memoryCapacity: 10 * 1024 * 1024, // 10 MB
                                          diskCapacity: 50 * 1024 * 1024, // 50 MB
                                          diskPath: nil)
        return URLSession(configuration: configuration)
    }()
    
    static let sharedInstance: NetworkManager = {
        NetworkManager()
    }()
    
    init(urlSession: URLSession = NetworkManager.defaultSession) {
        self.urlSession = urlSession
    }
    
    func performRequest<T: Decodable>(with provider: APIProvider, decodingType: T.Type) async throws -> T {
        let data = try await handleRequest(with: provider.request)
        if let decodedResponse = decode(T.self, from: data) {
            logger.info("✅ Data successfully fetched and decoded.")
            return decodedResponse
        } else {
            logger.error("❌ Failed to decode data received from \(provider.request.url?.absoluteString ?? "unknown URL")")
            if let json = data.toJSON() {
                logger.info("❌ \(json.debugDescription)")
            }
            throw NetworkError.decodingError(DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Failed to decode data.")))
        }
    }
    
    @discardableResult
    private func handleRequest(with request: URLRequest) async throws -> Data {
        logger.info("⬇️ Attempting to send request to \(request.url?.absoluteString ?? "unknown URL")")
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                logger.error("❌ Failed to cast response to HTTPURLResponse during request.")
                throw NetworkError.noData
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                logger.info("✅ Request successfully completed.")
                return data
            } else {
                logger.error("❌ HTTP request failed with status code: \(httpResponse.statusCode) \(request.url?.absoluteString ?? "")")
                throw NetworkError.noData
            }
        } catch {
            logger.error("❌ Request operation failed with error: \(error.localizedDescription)")
            throw error
        }
    }
}
