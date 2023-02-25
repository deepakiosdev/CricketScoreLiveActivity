//
//  CricketScoreBundle.swift
//  CricketScore
//
//  Created by Dipak Kumar Pandey on 12/02/23.
//

import WidgetKit
import SwiftUI

@main
struct CricketScoreBundle: WidgetBundle {
    var body: some Widget {
        CricketScore()
        CricketScoreLiveActivity()
    }
}
