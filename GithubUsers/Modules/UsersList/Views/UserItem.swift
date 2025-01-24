//
//  UserItem.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 22/1/25.
//

import SwiftUI

struct UserItem: View {
    var user: User
    var isInDetails: Bool = false
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            HStack {
                AsyncImage(url: user.avatar_url) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "photo")
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(user.login).font(.headline)
                    Divider()
                    if isInDetails {
                        HStack {
                            Image(systemName: "location.circle")
                            Text(user.location.or(" "))
                        }
                    } else if let url = user.html_url {
                        Text(url.absoluteString)
                            .font(.caption)
                            .foregroundStyle(.blue)
                            .underline()
                            .onTapGesture {
                                isPresented.toggle()
                            }
                    }
                }
            }
            if !isInDetails {
                NavigationLink(destination: UserDetailsView(viewModel: UserDetailsViewModel(user: user))) {}.opacity(0)
            }
        }
        .padding(15)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5, x: 0, y: 1)
        .listRowSeparator(.hidden)
        .sheet(isPresented: $isPresented) {
            WebviewPopup(url: user.html_url, isPresented: $isPresented)
        }
    }
}
