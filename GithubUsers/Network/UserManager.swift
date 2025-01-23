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
    
    static func getUserDetails(login: String, networkManager: NetworkManager) async throws -> User {
        do {
            let user = try await networkManager.performRequest(with: .getUserDetails(login: login), decodingType: User.self)
            return user
        } catch {
            throw error
        }
    }
}
