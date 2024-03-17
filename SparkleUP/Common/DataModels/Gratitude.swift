//
//  Gratitude.swift
//
//
//  Created by Roman Indermühle on 18.01.2024.
//

import Foundation
import SwiftData

@Model
class Gratitude: Hashable {
    var gratitudeValue1: String
    var gratitudeValue2: String
    var gratitudeValue3: String
    var createdAt: Date
    var recordedInSequence: Double
    
    init(gratitudeValue1: String, gratitudeValue2: String, gratitudeValue3: String, createdAt: Date = .now, recordedInSequence: Double) {
        self.gratitudeValue1 = gratitudeValue1
        self.gratitudeValue2 = gratitudeValue2
        self.gratitudeValue3 = gratitudeValue3
        self.createdAt = createdAt
        self.recordedInSequence = recordedInSequence
    }
}
