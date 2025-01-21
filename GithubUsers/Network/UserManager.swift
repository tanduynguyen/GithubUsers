//
//  UserManager.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 20/1/25.
//

import Foundation

struct UserManager {
    func fetchUsersList(page: Int = 0, completion: @escaping (Result<[User], Error>) -> Void) {
        // Create the URL to fetch
        guard let url = URL(string: Constants.apiURLString + "?per_page=\(page)&since=\(page * Constants.itemsPerPage)") else { fatalError("Invalid URL") }

        // Create the network manager
        let networkManager = NetworkManager()

        // Request data from the backend
        networkManager.request(fromURL: url) { (result: Result<[User], Error>) in
            completion(result)
         }

    }
}
