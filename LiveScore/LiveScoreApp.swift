//
//  LiveScoreApp.swift
//  LiveScore
//
//  Created by Dipak Kumar Pandey on 12/02/23.
//

import SwiftUI

@main
struct LiveScoreApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                //LiveActivityManager.shared.submitBackgroundTasks()
                LiveActivityManager.shared.scheduleAppRefresh()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         LiveActivityManager.shared.registerBackgroundTasks()
         return true
     }
 }
