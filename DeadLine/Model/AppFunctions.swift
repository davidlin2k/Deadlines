//
//  AppEngine.swift
//  DeadLine
//
//  Created by David Lin on 2022-09-22.
//

import Foundation
import UserNotifications

class AppFunctions {
    
    static func sendNotification(time: TimeInterval, deadlineTitle: String) -> String {
        let content = UNMutableNotificationContent()

        content.title = "Deadline \(deadlineTitle)"
        content.body = "Deadline \(deadlineTitle) is due!"
        content.sound = UNNotificationSound.default
        
        let uuid = UUID().uuidString
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        return uuid
    }
    
    static func cancelNotification(uuid: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [uuid])
    }
}
extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
