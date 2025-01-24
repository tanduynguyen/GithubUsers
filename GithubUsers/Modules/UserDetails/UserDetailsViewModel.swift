//
//  UserDetailsViewModel.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 23/1/25.
//

import Foundation

final class UserDetailsViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    @Published private(set) var user: User

    let userManager = UserManager()
    
    init(state: State = State.idle, user: User) {
        self.state = state
        self.user = user
    }
    
    @MainActor func getUserDetails() async {
        state = .loading
        do {
            let newUser = try await userManager.getUserDetails(login: user.login)
            self.user = newUser
            state = .success
        } catch {
            state = .failure(error)
        }
    }
}
