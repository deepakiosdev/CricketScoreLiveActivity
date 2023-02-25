//
//  LiveActivityManager.swift
//  LiveScore
//
//  Created by Dipak Kumar Pandey on 12/02/23.
//

import ActivityKit
import BackgroundTasks
import UIKit

public final class LiveActivityManager {
    // Declared at the "Permitted background task scheduler identifiers" in info.plist
    
    //30s is the time the system allows your task to execute per launch.
    let backgroundAppRefreshTaskSchedulerIdentifier = "com.dipak.paytmmoney.BGAppRefreshTaskRequestIdentifier"
   
    //Several minutes of run times to finish your work
    let backgroundProcessingTaskSchedulerIdentifier = "com.dipak.paytmmoney.BGProcessingTaskRequestIdentifier"
    
    public static let shared = LiveActivityManager()
    private var pinnedStockActivity: Activity<ScoreboardAttributes>?
    private init() {}
}

extension LiveActivityManager {
    
    func checkBackgroundRefreshStatus() {
        switch UIApplication.shared.backgroundRefreshStatus {
        case .available:
            print("Background fetch is enabled")
        case .denied:
            print("Background fetch is explicitly disabled")
            
            // Redirect user to Settings page only once; Respect user's choice is important
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        case .restricted:
            // Should not redirect user to Settings since he / she cannot toggle the settings
            print("Background fetch is restricted, e.g. under parental control")
        default:
            print("Unknown property")
        }
    }
    
    func registerBackgroundTasks() {
        checkBackgroundRefreshStatus()
        
        // Use the identifier which represents your needs
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundAppRefreshTaskSchedulerIdentifier, using: nil) { (task) in
            print("BackgroundAppRefreshTaskScheduler is executed NOW!")
            print("Background time remaining: \(UIApplication.shared.backgroundTimeRemaining)s")
            
            //            task.expirationHandler = {
            //                task.setTaskCompleted(success: false)
            //            }
            //
            //            // Do some data fetching and call setTaskCompleted(success:) asap!
            //            let isFetchingSuccess = true
            //            task.setTaskCompleted(success: isFetchingSuccess)
            //
            self.handleAppRefresh(task)
        }
    }
    
    func submitBackgroundTasks() {
        let timeDelay = 10.0
        do {
            let backgroundAppRefreshTaskRequest = BGAppRefreshTaskRequest(identifier: backgroundAppRefreshTaskSchedulerIdentifier)
            backgroundAppRefreshTaskRequest.earliestBeginDate = Date(timeIntervalSinceNow: timeDelay)
            try BGTaskScheduler.shared.submit(backgroundAppRefreshTaskRequest)
            print("Submitted task request")
        } catch {
            print("Failed to submit BGTask")
        }
    }
    
    ///////
    private func handleAppRefresh(_ task: BGTask) {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        let appRefreshOperation = BlockOperation {
            self.updateLiveScoreboardActivity()
        }
        queue.addOperation(appRefreshOperation)
        
        task.expirationHandler = {
            queue.cancelAllOperations()
        }
        
        let lastOperation = queue.operations.last
        lastOperation?.completionBlock = {
            task.setTaskCompleted(success: !(lastOperation?.isCancelled ?? false))
        }
        scheduleAppRefresh()
    }
    
    func scheduleAppRefresh() {
        do {
            let request = BGAppRefreshTaskRequest(identifier: backgroundAppRefreshTaskSchedulerIdentifier)
            request.earliestBeginDate = Date(timeIntervalSinceNow: 20)
            try BGTaskScheduler.shared.submit(request)
            print("Submitted task request")
        } catch {
            print("Failed to submit BGTask")
            print(error)
        }
    }
}
