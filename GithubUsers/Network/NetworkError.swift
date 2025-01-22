//
//  NetworkError.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 21/1/25.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError(Error)
    case serverError(String)
    
    var localizedDescription: String {
        switch self {
        case .serverError(let str):
            return str
        default:
            return "Something went wrong. Please try again."
        }
    }
}

protocol LocalizedError: Error {
    var localizedDescription: String { get }
}

func delay(time: TimeInterval = 0, _ block: @escaping(() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        block()
    }
}
