//
//  ContentView.swift
//  Multithreading-AsyncLet
//
//  Created by mac on 01/09/24.
//

import SwiftUI

struct AsyncLetView: View {
    @StateObject var viewModel = AsyncLetViewModel()
    
    var body: some View {
        HStack {
            if let stats = viewModel.stats {
                CardView(title: "Posts", count: stats.postsCount)
                CardView(title: "Followes", count: stats.followersCount)
                CardView(title: "Following", count: stats.followingCount)
            } else {
                ProgressView()
            }
        }
        .task {
            await viewModel.fetchUserStats()
        }
    }
}

struct CardView: View {
    let title: String
    let count: Int
    
    var body: some View {
        VStack {
            Text("\(count)")
            Text(title)
        }
        .frame(width: 100)
    }
}

#Preview {
    AsyncLetView()
}
