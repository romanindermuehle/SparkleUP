//
//  DailyTask.swift
//
//
//  Created by Roman Indermühle on 23.01.2024.
//

import Foundation
import SwiftUI

enum DailyTask: String ,CaseIterable {
    case mood = "moodDone"
    case quote = "quoteDone"
    case gratitude = "gratitudeDone"
}

extension DailyTask {
    @ViewBuilder
    var labelNotDone: some View {
        switch self {
        case .mood:
            Label("Define your mood of the day", systemImage: "seal")
        case .quote:
            Label("View your daily quote", systemImage: "seal")
        case .gratitude:
            Label("Write your daily gratitude", systemImage: "seal")
        }
    }
    
    
    @ViewBuilder
    var labelDone: some View {
        switch self {
        case .mood:
            Label("Define your mood of the day", systemImage: "checkmark.seal.fill")
        case .quote:
            Label("View your daily quote", systemImage: "checkmark.seal.fill")
        case .gratitude:
            Label("Write your daily gratitude", systemImage: "checkmark.seal.fill")
        }
    }
    
    
    
    @ViewBuilder
    var destination : some View {
        switch self {
        case .mood:
            MoodListView()
        case .quote:
            QuoteView()
        case .gratitude:
            GratitudeListView()
        }
    }
}
