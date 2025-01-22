//
//  ContentView.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 20/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink(destination: UsersList()) {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Github Users")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
