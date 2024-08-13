//
//  GratitudeUpdateView.swift
//
//
//  Created by Roman Indermühle on 18.01.2024.
//

import SwiftUI
import SwiftData
import TipKit

struct GratitudeModifyView: View {
    @Query(sort: \Day.startedAt) var days: [Day]
    @Query(sort: \Streak.addedAt) var streaks: [Streak]
    @Binding var gratitude: Gratitude?
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State var gratitudeValue1: String
    @State var gratitudeValue2: String
    @State var gratitudeValue3: String
    
    var isEditing: Bool
    
    var body: some View {
        Form {
            TextField("I'm grateful for...", text: $gratitudeValue1)
                .disabled(isEditing)
            HStack {
                if let streakCount = streaks.last?.count {
                    if streakCount >= 30 {
                        TextField("I'm grateful for...", text: $gratitudeValue2)
                    } else {
                        Image(systemName: "lock.badge.clock.fill")
                            .foregroundStyle(.accent)
                        TextField("Will unlock after \(30 - streakCount) days", text: $gratitudeValue2)
                            .disabled(true || isEditing)
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
                            .disabled(true || isEditing)
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
                .disabled(gratitudeValue1.isEmpty || isEditing)
                .fontWeight(.bold)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func saveGratitude() {
        if isEditing {
            gratitude?.gratitudeValue1 = gratitudeValue1
            gratitude?.gratitudeValue2 = gratitudeValue2
            gratitude?.gratitudeValue3 = gratitudeValue3
        } else {
            
            let new = Gratitude(gratitudeValue1: gratitudeValue1, gratitudeValue2: gratitudeValue2, gratitudeValue3: gratitudeValue3)
            context.insert(new)
        }
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

