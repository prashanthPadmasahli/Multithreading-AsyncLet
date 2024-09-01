//
//  AsyncLetViewModel.swift
//  Multithreading-AsyncLet
//
//  Created by mac on 01/09/24.
//

import Foundation

struct UserStats {
    let postsCount: Int
    let followersCount: Int
    let followingCount: Int
}

class AsyncLetViewModel: ObservableObject {
    @Published var stats: UserStats?
    
    @MainActor  /// takes 3 seconds
    func fetchUserStats() async {
        async let posts = fetchPosts()
        async let followers = fetchFollowers()
        async let followings = fetchFollowings()
        self.stats = await UserStats(postsCount: posts, followersCount: followers, followingCount: followings)
    }
    
    @MainActor  /// takes 6 seconds
    func fetchUserStatsLongerTime() async {
        let posts = await fetchPosts()
        let followers = await fetchFollowers()
        let followings = await fetchFollowings()
        self.stats = UserStats(postsCount: posts, followersCount: followers, followingCount: followings)
    }
    
    private func fetchPosts() async -> Int {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        return 9
    }
    
    private func fetchFollowers() async -> Int {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return 20
    }
    
    private func fetchFollowings() async -> Int {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return 25
    }
}
