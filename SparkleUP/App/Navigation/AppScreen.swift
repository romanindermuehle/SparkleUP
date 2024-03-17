//
//  File.swift
//  
//
//  Created by Roman Indermühle on 15.01.2024.
//

import SwiftUI


enum AppScreen: CaseIterable, Identifiable {
    case today
    case statistics
    case account
    
    var id: AppScreen { self }
    
}

extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .today:
            Label("Today", systemImage: "sun.max")
        case .statistics:
            Label("Statistics", systemImage: "chart.bar.fill")
        case .account:
            Label("Account", systemImage: "person.crop.circle.fill")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .today:
            TodayView()
        case .statistics:
            StatisticsView()
        case .account:
                AccountView()
        }
    }
}


