//
//  State.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 23/1/25.
//

enum LoadingState {
    case idle
    case loading
    case failure(Error)
    case success
}
