//
//  ContentView.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 20/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Github Users")
        }
        .padding()
        .onAppear {
            let userManager = UserManager()
            userManager.fetchUsersList { result in
                switch result {
                case .success(let users):
                    print(users)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
