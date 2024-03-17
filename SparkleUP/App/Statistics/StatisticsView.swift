//
//  StatisticsView.swift
//
//
//  Created by Roman Indermühle on 24.01.2024.
//

import SwiftUI
import SwiftData

struct StatisticsView: View {
    @Query var days: [Day]
    @Query var moods: [Mood]
    
        
    private var minimum = 0.0
    private var maximum = 100.0
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Day") {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(days) { day in
                            VStack(spacing: 10) {
                                ZStack(alignment: .center) {
                                    Text("\(day.percentage * 100, specifier: "%.0f")%")
                                        .font(.headline)
                                    ProgressRing(day: day, ringSizeHeight: 80, ringSizeWidth: 80, ringThickness: 10.0, ringHeight: 10.0, ringWidth: 10.0)
                                }
                           
                                Text(String(day.startedAt.formatted(date: .abbreviated, time: .omitted)))
                                    .font(.caption)
                            }
                        }
                    }
                    .padding()
                }
                
                Section("Moodlevel") {
                    if moods.isEmpty {
                        ContentUnavailableView {
                            Label("No recorded mood", systemImage: "square.and.pencil")
                        } description: {
                            Text("You haven't entered a mood yet. Add one via the \"Today\" view.")
                        }
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(moods) { mood in
                                VStack(spacing: 10) {
                                    Gauge(value: mood.moodLevel * 100, in: minimum...maximum) {
                                        Image(systemName: "percent")
                                    } currentValueLabel: {
                                        Text("\(mood.moodLevel * 100, specifier: "%.0f")")
                                    }
                                    .gaugeStyle(.accessoryCircular)
                                    .tint(Gradient(colors: [.darkMagenta.opacity(0.25), .darkMagenta.opacity(0.5), .lightMagenta, .darkMagenta, .darkerMagenta]))
                                    .scaleEffect(1.2)
                                    
                                    Text(String(mood.addedAt.formatted(date: .abbreviated, time: .omitted)))
                                        .font(.caption)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Statistics")
        }
    }
}


