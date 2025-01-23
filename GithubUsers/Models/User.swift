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
    var avatar_url: URL?
    var html_url: URL?
    var blog: URL?
    var location: String?
    var followers: Int?
    var following: Int?
}
