//
//  File.swift
//  
//
//  Created by Roman Indermühle on 15.01.2024.
//

import SwiftUI


enum AppScreen: CaseIterable, Identifiable {
    case today
    case progress
    case settings
    
    var id: AppScreen { self }
    
}

extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .today:
            Label("Today", systemImage: "sun.max")
        case .progress:
            Label("Progress", systemImage: "chart.bar.fill")
        case .settings:
            Label("Settings", systemImage: "gear")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .today:
            TodayView()
        case .progress:
            ProgressView()
        case .settings:
            SettingsView()
        }
    }
}


