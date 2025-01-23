//
//  UsersList.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 21/1/25.
//

import SwiftUI

struct UsersList: View {
    @StateObject private var viewModel = UsersListViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success:
                List(viewModel.users) { user in
                    UserItem(user: user)
                    if viewModel.users.isLastItem(user) {
                        HStack {
                            Spacer()
                            ProgressView()
                                .frame(alignment: .center)
                                .task {
                                    await viewModel.checkNextPage()
                                }
                            Spacer()
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .refreshable {
                    await viewModel.reload()
                }
            case .failure:
                GeometryReader { geometry in
                    ScrollView(.vertical) {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Failed to load Github users")
                            Spacer()
                        }
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
                    }
                    .refreshable {
                        await viewModel.reload()
                    }
                }
            case .idle:
                Color.clear
            }
        }
        .listRowSeparator(.hidden)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .listRowBackground(Constants.bgColor)
        .navigationBarTitle("Github Users")
        .task {
            await viewModel.fetchUsers()
        }
    }
}
