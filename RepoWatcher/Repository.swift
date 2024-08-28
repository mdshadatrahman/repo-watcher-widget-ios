//
//  Repository.swift
//  RepoWatcher
//
//  Created by Shadat Rahman on 28/8/24.
//

import Foundation


struct Repository: Decodable {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String
    
    static let placeholder = Repository(name: "Your Repo",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: true,
                                        forks: 55,
                                        watchers: 123,
                                        openIssues: 0,
                                        pushedAt: "2024-08-29T18:19:30Z")
    
    static let placeholder2 = Repository(name: "My Repo",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: false,
                                        forks: 0,
                                        watchers: 13,
                                        openIssues: 0,
                                        pushedAt: "2024-07-09T18:19:30Z")
}

struct Owner: Decodable {
    let avatarUrl: String
}
