//
//  APIProvider.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 21/1/25.
//

import Foundation

enum APIProvider {
    case getUsersList(page: Int)
    case getUserDetails(login: String)
}

extension APIProvider: ApiEndpoint {
    
    var baseURLString: String {
        Constants.apiURLString
    }
    
    var path: String {
        switch self {
        case .getUsersList(page: _):
            return "users"
        case .getUserDetails(login: let login):
            return "users/\(login)"
        }
    }
    
    var params: [String : Any]? {
        switch self {
        case .getUsersList(let page):
            return ["per_page": Constants.itemsPerPage, "since": Constants.itemsPerPage * page]
        default:
            return nil
        }
    }
    
    var method: HttpMethod? {
        .get
    }
}
