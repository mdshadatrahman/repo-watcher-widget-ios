//
//  RepoMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Shadat Rahman on 1/9/24.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
    let repo: Repository
    let formatter = ISO8601DateFormatter()
    
    var daysSinceLastActivity: Int {
        calculateDaysSinceLastActivity(from: repo.pushedAt)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: UIImage(data: repo.avatarData) ?? UIImage(named: "avatar")!)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                    Text(repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                }
                
                HStack {
                    StatLabel(value: repo.watchers, systemImageName: "star.fill")
                    StatLabel(value: repo.forks, systemImageName: "tuningfork")
                    if repo.hasIssues {
                        StatLabel(value: repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                    }
                }

            }
            Spacer()
            VStack {
                Text("\(daysSinceLastActivity)")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundStyle(daysSinceLastActivity > 7 ? .pink : .green)
                    .contentTransition(.numericText())
                
                Text("days ago")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    func calculateDaysSinceLastActivity(from dateString: String) -> Int {
        let lastActivityDate = formatter.date(from: dateString) ?? .now
        let daysSinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
        return daysSinceLastActivity
    }
}

struct RepoMediumView_Previews: PreviewProvider {
    static var previews: some View {
        RepoMediumView(repo: MockData.placeholder)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}


fileprivate struct StatLabel: View {
    let value: Int
    let systemImageName: String
    
    var body: some View {
        Label {
            Text("\(value)")
                .font(.footnote)
                .contentTransition(.numericText())
        } icon: {
            Image(systemName: systemImageName)
                .foregroundColor(.green)
        }
        .fontWeight(.medium)
    }
}
