//
//  Day.swift
//
//
//  Created by Roman Indermühle on 21.01.2024.
//

import Foundation
import SwiftData

@Model
class Day {
    var percentage: Double
    var tasksDone: [String]
    var sparkleSeen: Bool
    var startedAt: Date
    
    init(percentage: Double = 0.0, tasksDone: [String] = [], sparkleSeen: Bool = false, startedAt: Date = .now) {
        self.percentage = percentage
        self.tasksDone = tasksDone
        self.sparkleSeen = sparkleSeen
        self.startedAt = startedAt
    }
}
