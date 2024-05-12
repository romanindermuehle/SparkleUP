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
    @Binding var gratitude: Gratitude?
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State var gratitudeValue1: String
    @State var gratitudeValue2: String
    @State var gratitudeValue3: String
    @State var recordedInSequence: Double
    
    var isEditing: Bool
    var minimum = 0.0
    var maximum = 90.0
    
    
    
    var gratitudeTip = GratitudeTip()
    
    var body: some View {
        Form {
            if recordedInSequence <= 90 {
                Section {
                    VStack(alignment: .center) {
                        Text("Number of days of your gratitude")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        Gauge(value: recordedInSequence, in: minimum...maximum) {
                            Image(systemName: "percent")
                        } currentValueLabel: {
                            Text("\(recordedInSequence, specifier: "%.0f")")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("90")
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(Gradient(colors: [.lightMagenta, .darkMagenta]))
                    }
                    .popoverTip(gratitudeTip)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            TextField("I'm grateful for...", text: $gratitudeValue1)
                .disabled(isEditing)
            HStack {
                if recordedInSequence >= 30 {
                    TextField("I'm grateful for...", text: $gratitudeValue2)
                } else {
                    Image(systemName: "lock.badge.clock.fill")
                        .foregroundStyle(.accent)
                    TextField("Will unlock after 30 days", text: $gratitudeValue2)
                        .disabled(true || isEditing)
                }
            }
            HStack {
                if recordedInSequence >= 90 {
                    TextField("I'm grateful for...", text: $gratitudeValue3)
                } else {
                    Image(systemName: "lock.badge.clock.fill")
                        .foregroundStyle(.accent)
                    TextField("Will unlock after 90 days", text: $gratitudeValue3)
                        .disabled(true || isEditing)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveGratitude()
                }
                .disabled(gratitudeValue1.isEmpty || isEditing)
                .fontWeight(.bold)
            }
        }
        .navigationTitle("What are you grateful for today?")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func saveGratitude() {
        if isEditing {
            gratitude?.gratitudeValue1 = gratitudeValue1
            gratitude?.gratitudeValue2 = gratitudeValue2
            gratitude?.gratitudeValue3 = gratitudeValue3
            gratitude?.recordedInSequence = recordedInSequence
        } else {
            let newSequenceNumber = checkSequence(days: days, recordedInSequence: recordedInSequence)
            recordedInSequence += newSequenceNumber
            
            let new = Gratitude(gratitudeValue1: gratitudeValue1, gratitudeValue2: gratitudeValue2, gratitudeValue3: gratitudeValue3, recordedInSequence: recordedInSequence)
            context.insert(new)
        }
        markGratitudeDone()
        dismiss()
    }
    
    func checkSequence(days: [Day], recordedInSequence: Double) -> Double {
        let filteredDaysTaskDone = days.filter { $0.tasksDone.contains(where: { $0 == "gratitudeDone" }) }.sorted(by: { $0.startedAt < $1.startedAt })
        let lastTwoDays = filteredDaysTaskDone.suffix(2)
        
        guard let fromDate  = lastTwoDays.first?.startedAt else { return 0.0 }
        guard let toDate  = lastTwoDays.last?.startedAt else { return 0.0 }
        let isNotToday = !Calendar.current.isDateInToday(toDate)
        
        if let dayDifference = calculateDayDifference(fromDate: fromDate, toDate: toDate) {
            if dayDifference < 2 && isNotToday {
                return 1.0
            } else if recordedInSequence < 1 {
                return 1.0
            }
        }
        return 0.0
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
    
    func calculateDayDifference(fromDate: Date, toDate: Date) -> Int? {
        Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day
    }
}

