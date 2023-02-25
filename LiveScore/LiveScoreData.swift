//
//  LiveScoreData.swift
//  LiveScore
//
//  Created by Dipak Kumar Pandey on 12/02/23.
//

import Foundation
import ActivityKit

extension LiveActivityManager {
    
    func getLiveScore() -> LiveScoreResponseModel {
        let jsonData = scorecardJSON.data(using: .utf8)!
        let responseModel: LiveScoreResponseModel = try! JSONDecoder().decode(LiveScoreResponseModel.self, from: jsonData)
        return responseModel
    }
    
    func startScoreActivity() {
        let response = getLiveScore()
        let scoreboardAttributes = ScoreboardAttributes(teamName: "IND", opponentName: "AUS", opponentTotal: "300")
        let initialContentState = ScoreboardAttributes.ScoreboardStatus(liveScore: response)
                                                  
        do {
            let orderActivity = try Activity<ScoreboardAttributes>.request(
                attributes: scoreboardAttributes,
                contentState: initialContentState,
                pushType: nil)
            print("Requested scoreboard Live Activity \(orderActivity.id)")
        } catch (let error) {
            print("Error scoreboard Live Activity \(error.localizedDescription)")
        }
    }
    
    func updateLiveScoreboardActivity() {
        print("Updating Score")
        // Update live activity
        Task {
            var response = getLiveScore()
            let randomRun = Int.random(in: 150 ..< 200)
            response.runs = randomRun
            print("Updated Run: \(randomRun)")
            let initialContentState = ScoreboardAttributes.ScoreboardStatus(liveScore: response)
            for activity in Activity<ScoreboardAttributes>.activities{
                await activity.update(using: initialContentState)
            }
        }
    }
        
    func endScoreActivity() {
        
    }
}

