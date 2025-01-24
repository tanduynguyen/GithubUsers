//
//  UserDetailsView.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 23/1/25.
//

import SwiftUI

struct UserDetailsView: View {
    @StateObject var viewModel: UserDetailsViewModel
    @State private var isPresented = false

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success, .failure:
                List {
                    UserItem(user: viewModel.user, isInDetails: true)
                    HStack {
                        Spacer()
                        FollowView(user: viewModel.user, isFolllowing: false)
                        Spacer()
                        FollowView(user: viewModel.user, isFolllowing: true)
                        Spacer()
                    }
                    if let url = viewModel.user.blog {
                        Text("Blog").font(.headline)
                            .listRowSeparator(.hidden)
                        Text(url.absoluteString)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .onTapGesture {
                                isPresented.toggle()
                            }
                            .listRowSeparator(.hidden)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Constants.bgColor)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .sheet(isPresented: $isPresented) {
                    WebviewPopup(url: viewModel.user.blog, isPresented: $isPresented)
                }
            case .idle:
                Color.clear
            }
        }
        .navigationBarTitle("User Details")
        .task {
            await viewModel.getUserDetails()
        }
    }
}
