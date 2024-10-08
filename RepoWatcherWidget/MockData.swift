//
//  MockData.swift
//  RepoWatcherWidgetExtension
//
//  Created by Shadat Rahman on 2/9/24.
//

import Foundation

struct MockData {
    static let placeholder = Repository(name: "Your Repo",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: true,
                                        forks: 55,
                                        watchers: 123,
                                        openIssues: 0,
                                        pushedAt: "2024-08-29T18:19:30Z",
                                        avatarData: Data(),
                                        contributors: [
                                            Contributor(login: "Sean Allen", avatarUrl: "", contributions: 12, avatarData: Data()),
                                            Contributor(login: "Michael Jordan", avatarUrl: "", contributions: 12, avatarData: Data()),
                                            Contributor(login: "Steph Curry", avatarUrl: "", contributions: 12, avatarData: Data()),
                                            Contributor(login: "LeBron James", avatarUrl: "", contributions: 12, avatarData: Data()),
                                        ]
    )
    
    static let placeholder2 = Repository(name: "My Repo",
                                         owner: Owner(avatarUrl: ""),
                                         hasIssues: false,
                                         forks: 0,
                                         watchers: 13,
                                         openIssues: 0,
                                         pushedAt: "2024-07-09T18:19:30Z",
                                         avatarData: Data(),
                                         contributors: [
                                             Contributor(login: "Shadat Rahman", avatarUrl: "", contributions: 1, avatarData: Data()),
                                             Contributor(login: "Ann Marie", avatarUrl: "", contributions: 1211, avatarData: Data()),
                                         ]
    )
}
