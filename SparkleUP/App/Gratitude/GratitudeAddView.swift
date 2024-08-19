//
//  GratitudeUpdateView.swift
//
//
//  Created by Roman Indermühle on 18.01.2024.
//

import SwiftUI
import SwiftData

struct GratitudeAddView: View {
    @Query(sort: \Day.startedAt) var days: [Day]
    @Query(sort: \Streak.addedAt) var streaks: [Streak]
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State var gratitudeValue1: String
    @State var gratitudeValue2: String
    @State var gratitudeValue3: String
    
    var body: some View {
        Form {
            Section {
                ZStack(alignment: .topLeading) {
                    if gratitudeValue1.isEmpty {
                        Text("I'm grateful for...")
                            .foregroundStyle(Color(UIColor.placeholderText))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                    }
                    TextEditor(text: $gratitudeValue1)
                        .padding(4)
                }
            }
            
            Section {
                if let streakCount = streaks.last?.count {
                    if streakCount >= 30 {
                        ZStack(alignment: .topLeading) {
                            if gratitudeValue2.isEmpty {
                                Text("I'm grateful for...")
                                    .foregroundStyle(Color(UIColor.placeholderText))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                            }
                            TextEditor(text: $gratitudeValue2)
                                .padding(4)
                        }
                    } else {
                        HStack {
                            Image(systemName: "lock.badge.clock.fill")
                                .foregroundStyle(.accent)
                            Text("Will unlock after \(30 - streakCount) days")
                                .foregroundStyle(Color(UIColor.placeholderText))
                        }
                    }
                }
            }
            
            Section {
                if let streakCount = streaks.last?.count {
                    if  streakCount >= 90 {
                        ZStack(alignment: .topLeading) {
                            if gratitudeValue3.isEmpty {
                                Text("I'm grateful for...")
                                    .foregroundStyle(Color(UIColor.placeholderText))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                            }
                            TextEditor(text: $gratitudeValue3)
                                .padding(4)
                        }
                    } else {
                        HStack {
                            Image(systemName: "lock.badge.clock.fill")
                                .foregroundStyle(.accent)
                            Text("Will unlock after \(90 - streakCount) days")
                                .foregroundStyle(Color(UIColor.placeholderText))
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("What are you grateful for today?")
                    .font(.headline)
                    .fixedSize(horizontal: true, vertical: false)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveGratitude()
                }
                .disabled(gratitudeValue1.isEmpty)
                .fontWeight(.semibold)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func saveGratitude() {
        let gratitude = Gratitude(gratitudeValue1: gratitudeValue1, gratitudeValue2: gratitudeValue2, gratitudeValue3: gratitudeValue3)
        context.insert(gratitude)
        
        markGratitudeDone()
        dismiss()
    }
    
    func markGratitudeDone() {
        if let day = days.last {
            if day.tasksDone.contains(where: { $0 == "gratitudeDone" }) {
                
                if day.tasksDone.count == 3 {
                    day.percentage += 0.4
                }
            } else {
                day.tasksDone.append("gratitudeDone")
                
                day.percentage += 0.4
                
            }
        }
    }
}

