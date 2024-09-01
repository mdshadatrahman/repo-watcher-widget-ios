//
//  RepoWatcherWidgetBundle.swift
//  RepoWatcherWidget
//
//  Created by Shadat Rahman on 28/8/24.
//

import WidgetKit
import SwiftUI

@main
struct RepoWatcherWidgets: WidgetBundle {
    var body: some Widget {
        CompactRepoWidget()
        ContributorWidget()
    }
}
