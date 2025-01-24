//
//  GithubUsersTests.swift
//  GithubUsersTests
//
//  Created by Duy Nguyen on 20/1/25.
//

import Testing
import Foundation
import XCTest
import SwiftUI

struct GithubUsersTests {

    @Test func testGithubAPI() async throws {
        let dataAndResponse: (data: Data, respose: URLResponse) = try await URLSession.shared.data(from: URL(string: Constants.apiURLString)!)
        let httpResponse = try XCTUnwrap(dataAndResponse.respose as? HTTPURLResponse, "Expected an HTTPURLResponse")
        
        XCTAssertEqual(httpResponse.statusCode, 200, "Expected a 200 status code")
    }

    @Test func testGithubUsersAPI() async throws {
        let userManager = UserManager()
        let users: [User]? = try await userManager.fetchUsersList(since: 0)
        
        #expect(users != nil, "Expected data is not nil")
    }
    
    @Test func testGithubUserDetailsAPI() async throws {
        let userManager = UserManager()
        let user: User = try await userManager.getUserDetails(login: "tanduynguyen")
        
        #expect(user.name == "Duy Nguyen", "Expected that user name is Duy Nguyen")
    }
}
