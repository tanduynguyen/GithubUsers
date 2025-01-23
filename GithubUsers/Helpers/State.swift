//
//  State.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 23/1/25.
//

enum State {
    case idle
    case loading
    case failure(Error)
    case success
}
