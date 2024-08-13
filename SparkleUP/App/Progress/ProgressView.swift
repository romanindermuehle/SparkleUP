//
//  StatisticsView.swift
//
//
//  Created by Roman Indermühle on 24.01.2024.
//

import SwiftUI
import SwiftData

struct ProgressView: View {
    @Query(sort: \Day.startedAt) var days: [Day]
    @Query(sort: \Streak.addedAt) var streaks: [Streak]
    
    @State var bestStreakCount: Int = 0
    
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack {
                        Color.darkMagenta
                            .frame(minWidth: 154, maxWidth: 185, minHeight: 154, maxHeight: 185)
                            .clipShape(Circle())
                        
                        VStack {
                            Text("\(streaks.last?.count ?? 0)")
                                .font(.system(size: 64))
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                            
                            Text("DAYS")
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.bottom)
                    
                    GroupBox {
                        HStack {
                            Image(systemName: "flame.circle.fill")
                                .resizable()
                                .frame(maxWidth: 34, maxHeight: 34)
                                .foregroundStyle(.lightMagenta)
                            
                            VStack(alignment: .leading) {
                                Text("Your best streak")
                                Text("\(bestStreakCount) DAYS")
                                    .font(.headline)
                            }
                        }
                        .padding(.bottom)
                        
                        CalendarView(days: days)
                    }
                    .padding()
                    
                    Spacer()
                    
                }
            }
            .navigationTitle("Your Progress")
        }
        .task {
            bestStreakCount = streaks.map { $0.count }.max() ?? 0
            
            let lastCount = streaks.suffix(2).first?.count
            
            if let streak = streaks.last {
                if let newStreakCount = checkStreak(streak: streak, lastStreakCount: lastCount ?? 0, days: days) {
                    streak.count = newStreakCount
                    streak.lastUpdated = Date()
                }
            }
        }
    }
    
    func checkStreak(streak: Streak, lastStreakCount: Int, days: [Day]) -> Int? {
        let today = days.last
        let yesterday = days.filter { $0.startedAt.formatted(date: .abbreviated, time: .omitted) == Calendar.current.date(byAdding: .day, value: -1, to: Date())?.formatted(date: .abbreviated, time: .omitted) }.last
        
        if yesterday?.percentage ?? 0 >= 1.0 && today?.percentage ?? 0 >= 1.0 && streak.lastUpdated == nil {
            return lastStreakCount + 1
        } else if today?.percentage ?? 0 >= 1.0 && streak.lastUpdated == nil  {
            return 1
        }
        
        return nil
        
    }
    
}


