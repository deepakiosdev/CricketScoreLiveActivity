//
//  LiveScoreResponseModel.swift
//  LiveScore
//
//  Created by Dipak Kumar Pandey on 12/02/23.
//

import Foundation

public struct LiveScoreResponseModel: Codable, Hashable {
    var runs: Int
    var overs: Float
    var wickets: Int
}

let scorecardJSON = """
{
    "runs": 130,
    "overs": 13.1,
    "wickets": 1
}
"""
