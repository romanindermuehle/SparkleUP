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
            TextField("I'm grateful for...", text: $gratitudeValue1)
            HStack {
                if let streakCount = streaks.last?.count {
                    if streakCount >= 30 {
                        TextField("I'm grateful for...", text: $gratitudeValue2)
                    } else {
                        Image(systemName: "lock.badge.clock.fill")
                            .foregroundStyle(.accent)
                        TextField("Will unlock after \(30 - streakCount) days", text: $gratitudeValue2)
                            .disabled(streakCount <= 30)
                    }
                }
            }
            HStack {
                if let streakCount = streaks.last?.count {
                    if  streakCount >= 90 {
                        TextField("I'm grateful for...", text: $gratitudeValue3)
                    } else {
                        Image(systemName: "lock.badge.clock.fill")
                            .foregroundStyle(.accent)
                        TextField("Will unlock after \(90 - streakCount) days", text: $gratitudeValue3)
                            .disabled(streakCount <= 90)
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
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    saveGratitude()
                } label: {
                    Text("Save")
                        .fontWeight(.semibold)
                        .frame(minWidth: 250, minHeight: 50)
                        .background(gratitudeValue1.isEmpty ? Color.gray : Color.accent)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
                .disabled(gratitudeValue1.isEmpty)
                .padding(.bottom)
               
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

