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
    @Query var days: [Day]
    @Binding var gratitude: Gratitude?
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State var gratitudeValue1: String
    @State var gratitudeValue2: String
    @State var gratitudeValue3: String
    @State var recordedInSequence: Double
    
    var isEditing: Bool
    let currentDate = Date()
    var minimum = 0.0
    var maximum = 90.0
    
    
    
    var gratitudeTip = GratitudeTip()
    
    var body: some View {
        Form {
            Section {
                TipView(gratitudeTip, arrowEdge: .bottom)
                    .padding()
                    #if os(iOS)
                    .tipBackground(Color.accentColor.opacity(0.1))
                    #endif
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            
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
                        .foregroundStyle(Color.accentColor)
                    TextField("Unlocked after 30 days", text: $gratitudeValue2)
                        .disabled(true || isEditing)
                }
            }
            HStack {
                if recordedInSequence >= 90 {
                    TextField("I'm grateful for...", text: $gratitudeValue3)
                } else {
                    Image(systemName: "lock.badge.clock.fill")
                        .foregroundStyle(Color.accentColor)
                    TextField("Unlocked after 90 days", text: $gratitudeValue3)
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
            checkSequence()
            let new = Gratitude(gratitudeValue1: gratitudeValue1, gratitudeValue2: gratitudeValue2, gratitudeValue3: gratitudeValue3, recordedInSequence: recordedInSequence)
            context.insert(new)
        }
        markGratitudeDone()
        dismiss()
    }
    
    func checkSequence() {
        if let day = days.last {
            if day.tasksDone.contains(where: { $0 == "gratitudeDone" }) {
                if day.startedAt.formatted(date: .abbreviated, time: .omitted) == currentDate.formatted(date: .abbreviated, time: .omitted) {
                    return
                } else {
                    recordedInSequence += 1.0
                    print(recordedInSequence)
                }
            }
        } else {
            recordedInSequence += 1.0
            print(recordedInSequence)
        }
    }
    
    func markGratitudeDone() {
        if let day = days.last {
            if day.tasksDone.contains(where: { $0 == "gratitudeDone" }) {
                
                if day.tasksDone.count == 3 {
                    day.percentage += 0.4
                } else {
                    return
                }
        
                return
            } else {
                day.tasksDone.append("gratitudeDone")
                
                day.percentage += 0.4
                
            }
        }
    }
}

