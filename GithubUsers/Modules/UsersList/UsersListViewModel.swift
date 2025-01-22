//
//  UsersListViewModel.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 21/1/25.
//

import Foundation

enum State {
    case idle
    case loading
    case failure(Error)
    case success
}

final class UsersListViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    @Published private(set) var users: [User] = []
    private(set) var page: Int = 0
    private(set) var hasMoreRows = false
    let networkManager = NetworkManager()
    
    @MainActor func fetchUsers() async {
        switch state {
        case .loading:
            return
        default:
            break
        }
        state = .loading
        do {
            let newUsers = try await UserManager.fetchUsersList(page: page, networkManager: networkManager)
            hasMoreRows = newUsers.count == Constants.itemsPerPage
            users.append(contentsOf: newUsers)
            state = .success
        } catch {
            state = .failure(error)
        }
    }
    
    func checkNextPage() async {
        page += 1
        await fetchUsers()
    }
    
    func reload() async {
        page = 0
        await fetchUsers()
    }
}
