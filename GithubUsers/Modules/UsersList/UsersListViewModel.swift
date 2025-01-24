//
//  UsersListViewModel.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 21/1/25.
//

import Foundation

final class UsersListViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    @Published private(set) var users: [User] = []
    private(set) var since: Int = 0
    private(set) var hasMoreRows = false
    let userManager = UserManager()
    
    @MainActor func reloadUsers() async {
        since = 0
        users = []
        state = .loading
        do {
            try await fetchUsersList()
            state = .success
        } catch {
            state = .failure(error)
        }
    }
    
    @MainActor func fetchNextUsers() async {
        do {
            try await fetchUsersList()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetchUsersList() async throws {
        let newUsers = try await userManager.fetchUsersList(since: since)
        hasMoreRows = newUsers.count == Constants.itemsPerPage
        since = newUsers.last?.id ?? 0

        // Publishing changes from background threads is not allowed
        await MainActor.run {
            users.append(contentsOf: newUsers)
        }
    }
}
