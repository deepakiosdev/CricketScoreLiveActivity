//
//  CricketScoreLiveActivity.swift
//  CricketScore
//
//  Created by Dipak Kumar Pandey on 12/02/23.
//

import ActivityKit
import WidgetKit
import SwiftUI


struct CricketScoreLiveActivity: Widget {
    let firstTeam = ScoreCardModel(teamName: "AUS", teamLogo: "aus_logo", score: "327/4", overs: "50")

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ScoreboardAttributes.self) { context in
            
            let score = "\((context.state.liveScore?.runs ?? 0))/\((context.state.liveScore?.wickets ?? 0))"
            let overs = "\(context.state.liveScore?.overs ?? 0)"
            let secondTeam = ScoreCardModel(teamName: "IND", teamLogo: "ind_logo", score: score, overs: overs)

            LockScreenView(teams: [firstTeam, secondTeam])
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            
            DynamicIsland {
                let score = "\((context.state.liveScore?.runs ?? 0))/\((context.state.liveScore?.wickets ?? 0))"
                let overs = "(\(context.state.liveScore?.overs ?? 0))"

                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text(score)
                    Text(overs)
                        .font(.caption2)

                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("IND")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("\(firstTeam.teamName) \(firstTeam.score)")
                    Text("(\(firstTeam.overs))")
                        .font(.caption2)

                }
            } compactLeading: {
                Text("\((context.state.liveScore?.runs ?? 0))/\((context.state.liveScore?.wickets ?? 0))")
            } compactTrailing: {
                Text("IND")
            } minimal: {
                Text("\(context.state.liveScore?.runs ?? 0)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
