//
//  APIProvider.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 21/1/25.
//

import Foundation

enum APIProvider {
    case getUsersList(since: Int)
    case getUserDetails(login: String)
}

extension APIProvider: ApiEndpoint {
    
    var baseURLString: String {
        Constants.apiURLString
    }
    
    var path: String {
        switch self {
        case .getUsersList:
            return "users"
        case .getUserDetails(login: let login):
            return "users/\(login)"
        }
    }
    
    var params: [String : Any]? {
        switch self {
        case .getUsersList(let since):
            return ["per_page": Constants.itemsPerPage, "since": since]
        default:
            return nil
        }
    }
    
    var method: HttpMethod? {
        .get
    }
}
