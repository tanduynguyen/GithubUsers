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
//                    NavigationLink(destination: PhotoDetail(photo: photo)) {
                        HStack {
                            AsyncImage(url: user.avatar_url) { image in
                                image.resizable()
                            } placeholder: {
                                Image(systemName: "photo")
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            Text(user.login)
                        }
//                    }
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
        .listStyle(.plain)
        .navigationBarTitle("Github Users")
        .task {
            await viewModel.fetchUsers()
        }
    }
}
