//
//  UserManager.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 20/1/25.
//

import Foundation

struct UserManager {
    static func fetchUsersList(page: Int, networkManager: NetworkManager) async throws -> [User] {
        do {
            let users = try await networkManager.performRequest(with: .getUsersList(page: page), decodingType: [User].self)
            return users
        } catch {
            throw error
        }
    }
}
