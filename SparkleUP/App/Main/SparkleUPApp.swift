//
//  SparkleUPApp.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 17.03.2024.
//

import SwiftUI
import TipKit
import SwiftData

@main
struct SparkleUPApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    @State var showOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                ContentView()
                    .onAppear {
                        showOnboarding = true
                    }
                    .fullScreenCover(isPresented: $showOnboarding) {
                        OnboardingView()
                    }
            } else {
                ContentView()
                    .task {
                        try? Tips.configure([
                            .displayFrequency(.immediate)
                        ])
                    }
            }
        }
        .modelContainer(for: [Gratitude.self, Day.self, Mood.self, Quote.self, Streak.self, User.self])
    }
}
