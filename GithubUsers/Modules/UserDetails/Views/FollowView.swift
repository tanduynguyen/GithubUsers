//
//  FollowView.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 23/1/25.
//

import SwiftUICore

struct FollowView: View {
    var user: User
    var isFolllowing: Bool
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: isFolllowing ? "rosette" : "person.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(10)
            }
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            Text(user.followers.or(0).formatted())
            Text(isFolllowing ? "Following" : "Follower")
                .foregroundStyle(Color.gray)
                .font(.caption)
        }
    }
}
