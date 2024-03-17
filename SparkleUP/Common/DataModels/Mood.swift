//
//  Mood.swift
//
//
//  Created by Roman Indermühle on 21.01.2024.
//

import Foundation
import SwiftData

@Model
class Mood {
    var moodLevel: Double
    var addedAt: Date
    
    init(moodLevel: Double, addedAt: Date = .now) {
        self.moodLevel = moodLevel
        self.addedAt = addedAt
    }
    
}
