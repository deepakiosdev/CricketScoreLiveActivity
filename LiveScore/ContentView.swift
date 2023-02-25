//
//  ContentView.swift
//  LiveScore
//
//  Created by Dipak Kumar Pandey on 12/02/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Live cricket score 🏏")
            actionButtons
        }
        .padding()
    }
}

extension ContentView {
    var actionButtons: some View {
        VStack(spacing:0) {
            Spacer()
            
            HStack(spacing:0) {
                Button(action: { LiveActivityManager.shared.startScoreActivity() }) {
                    HStack {
                        Spacer()
                        Text("Start Activity 🏏").font(.headline)
                        Spacer()
                    }.frame(height: 60)
                }.tint(.blue)
                Button(action: { LiveActivityManager.shared.updateLiveScoreboardActivity() }) {
                    HStack {
                        Spacer()
                        Text("Update Score 🫠 ").font(.headline)
                        Spacer()
                    }.frame(height: 60)
                }.tint(.purple)
            }.frame(maxWidth: UIScreen.main.bounds.size.width)
            
            Button(action: { LiveActivityManager.shared.endScoreActivity() }) {
                HStack {
                    Spacer()
                    Text("End Activity 🛑").font(.headline)
                    Spacer()
                }.frame(height: 60)
                .padding(.bottom)
            }.tint(.pink)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 0))
        .ignoresSafeArea(edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
