//
//  ApiEndpoint.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 21/1/25.
//

import Foundation

/// The request method you like to use
enum HttpMethod: String {
    case get
    case post

    var method: String { rawValue.uppercased() }
}

protocol ApiEndpoint {
    var baseURLString: String { get }
    var path: String { get }
    var params: [String: Any]? { get }
    var method: HttpMethod? { get }
}

extension ApiEndpoint {
    var request: URLRequest {
        var urlComponents = URLComponents(string: baseURLString)
        urlComponents?.path = "/" + path
        
        guard var url = urlComponents?.url else { return URLRequest(url: URL(string: baseURLString)!) }
        if let params = params, method == .get {
            let queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            url = url.appending(queryItems: queryItems)
        }
        var request = URLRequest(url: url)
        if let method = method {
            request.httpMethod = method.rawValue
        }
        
        if let params = params, method != .get {
            let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        return request
    }
    
    var urlString: String {
        request.url?.absoluteString ?? "unknown URL"
    }
}
