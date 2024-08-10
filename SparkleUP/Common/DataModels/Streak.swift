//
//  Streak.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 15.07.2024.
//

import Foundation
import SwiftData

@Model
class Streak {
    var count: Int = 0
    var addedAt: Date = Date()
    var lastUpdated: Date?
    
    init(count: Int = 0, addedAt: Date = Date(), lastUpdated: Date?) {
        self.count = count
        self.addedAt = addedAt
        self.lastUpdated = lastUpdated
    }
}
