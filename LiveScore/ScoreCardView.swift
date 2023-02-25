//
//  ScoreCardView.swift
//  LiveScore
//
//  Created by Dipak Kumar Pandey on 12/02/23.
//

import SwiftUI

struct LockScreenView: View {
    private let teams: [ScoreCardModel]
    @Environment(\.colorScheme) var colorScheme
    
    init(teams: [ScoreCardModel]) {
        self.teams = teams
    }
    
    var body: some View {
        HStack {
            ScoreCardView(model: teams[0])
            Spacer()
            ScoreCardView(model: teams[1])
        }
        .padding()
    }
}

struct ScoreCardView: View {
    
    private let model: ScoreCardModel
    @Environment(\.colorScheme) var colorScheme
    
    init(model: ScoreCardModel) {
        self.model = model
    }
    
    var body: some View {
        HStack {
            VStack {
                Image(model.teamLogo)
                Text(model.teamName)
                    .font(.caption)
            }
            
           // Spacer()
            
            VStack {
                Text(model.score)
                    .font(.caption)
                Text("(\(model.overs))")
                    .font(.caption2)
            }
        }
        .padding()
    }
}

public struct ScoreCardModel {
    let teamName: String
    let teamLogo: String
    let score: String
    let overs: String
}
