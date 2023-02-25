//
//  ScoreboardAttributes.swift
//  LiveScore
//
//  Created by Dipak Kumar Pandey on 12/02/23.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct ScoreboardAttributes: ActivityAttributes {
    public typealias ScoreboardStatus = ContentState

    //Dynamic Properties
    public struct ContentState: Codable, Hashable {
        public let liveScore: LiveScoreResponseModel?
    }
    
    //Static Properties
    var teamName = ""
    var opponentName = ""
    var opponentTotal = "" //325/7(50)
}

