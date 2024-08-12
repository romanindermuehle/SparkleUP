//
//  ContentView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 17.03.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Day.startedAt) var days: [Day]
    @State var selection: AppScreen? = .today
    var body: some View {
        AppTabView(selection: $selection)
            .task {
                if let newDay = createNewDay(days: days) {
                    context.insert(newDay.day)
                    context.insert(newDay.streak)
                }
            }
    }
    
    func createNewDay(days: [Day]) -> (day: Day, streak: Streak)? {
        if !days.contains(where: { $0.startedAt.formatted(date: .abbreviated, time: .omitted) == Date().formatted(date: .abbreviated, time: .omitted) }) {
            let day = Day.init()
            let streak = Streak(lastUpdated: nil)
            
            return (day, streak)
        }
        
        return nil
    }
}

#Preview {
    ContentView()
}
