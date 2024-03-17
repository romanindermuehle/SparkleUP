//
//  MoodAddView.swift
//
//
//  Created by Roman Indermühle on 21.01.2024.
//

import SwiftUI
import SwiftData
import TipKit

struct MoodModifyView: View {
    @Query var days: [Day]
    @Binding var mood: Mood?
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State var moodLevel: Double
    
    var getWord = MoodLevel.colorToWord
    var getColor = MoodLevel.valueToColor
    
    var batteryTip = BatteryTip()
    var isEditing: Bool
    
    @State private var current = 0.0
    @State private var minimum = 0.0
    @State private var maximum = 100.0
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(moodLevel * 100, specifier: "%.0f")%")
                .font(.system(size: 56, weight: .black))
                .foregroundStyle(getColor(moodLevel))
            
            MoodBarometer(moodLevel: $moodLevel, levelColor: moodLevel)
                .frame(width: 250, height: 90)
                .padding()
            
            TipView(batteryTip, arrowEdge: .top)
                .padding()
                .tipBackground(Color.accentColor.opacity(0.1))
            
            Spacer()
            
            Text("\(getWord(getColor(moodLevel)))")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(getColor(moodLevel))
            
            Slider(value: $moodLevel, in: 0...1)
                .disabled(isEditing)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveMood()
                }
                .disabled(isEditing || moodLevel <= 0.01)
                .fontWeight(.bold)
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    saveMood()
                } label: {
                    Text("Save")
                        .frame(width: 250, height: 50)
                        .font(.title2)
                        .fontWeight(.bold)
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding()
                    
                }
                .padding(.bottom)
                .disabled(isEditing || moodLevel <= 0.01)
            }
        }
        .navigationTitle("Choose your Mood Level")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func saveMood() {
        if isEditing {
            mood?.moodLevel = moodLevel
        } else {
            let new = Mood(moodLevel: moodLevel)
            context.insert(new)
        }
        markMoodDone()
        dismiss()
    }
    
    func markMoodDone() {
        if let day = days.last {
            if day.tasksDone.contains(where: { $0 == "moodDone" }) {
                
                if day.tasksDone.count == 3 {
                    day.percentage += 0.3
                } else {
                    return
                }
                
                return
            } else {
                day.tasksDone.append("moodDone")
                
                day.percentage += 0.3
                
            }
        }
    }
}


