//
//  UserManager.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 20/1/25.
//

import Foundation

struct UserManager {
    let networkManager = NetworkManager()
    
    func fetchUsersList(since: Int) async throws -> [User] {
        do {
            let users = try await networkManager.performRequest(with: .getUsersList(since: since), decodingType: [User].self)
            return users
        } catch {
            throw error
        }
    }
    
    func getUserDetails(login: String) async throws -> User {
        do {
            let user = try await networkManager.performRequest(with: .getUserDetails(login: login), decodingType: User.self)
            return user
        } catch {
            throw error
        }
    }
}
