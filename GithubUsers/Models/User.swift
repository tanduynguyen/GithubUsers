//
//  User.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 20/1/25.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: Int
    let login: String
    var avatarUrl: URL?
    var htmlUrl: URL?
    var blog: URL?
    var location: String?
    var followers: Int?
    var following: Int?
    var name: String?
}

extension User {
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case blog
        case location
        case followers
        case following
    }
}
