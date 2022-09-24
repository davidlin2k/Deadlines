//
//  DeadlineRowDataModel.swift
//  DeadLine
//
//  Created by David Lin on 2022-09-22.
//

import Foundation
import RealmSwift


class Deadline: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var startTime: Date
    @Persisted var endTime: Date
    @Persisted var title: String
    
    convenience init(startTime: Date, endTime: Date, title: String) {
        self.init()
        self.startTime = startTime
        self.endTime = endTime
        self.title = title
    }
    
    func getTimeLeft() -> String {
        let formatter = DateComponentsFormatter()

        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        
        return formatter.string(from: endTime - Date()) ?? ""
    }
    
    func getStartTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm/dd/yy"
        
        return formatter.string(from: startTime)
    }
    
    func getEndTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm"
        
        return formatter.string(from: endTime)
    }
}

class DeadlineRowDataModel {
    let startTime: Date
    let endTime: Date
    let title: String
    
    init(startTime: Date, endTime: Date, title: String) {
        self.startTime = startTime
        self.endTime = endTime
        self.title = title
    }
    
    func getTimeLeft() -> String {
        let formatter = DateComponentsFormatter()

        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        
        return formatter.string(from: endTime - Date()) ?? ""
    }
    
    func getStartTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm/dd/yy"
        
        return formatter.string(from: startTime)
    }
    
    func getEndTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm"
        
        return formatter.string(from: endTime)
    }
}
