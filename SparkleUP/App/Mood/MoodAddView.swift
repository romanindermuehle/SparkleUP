//
//  MoodAddView.swift
//
//
//  Created by Roman Indermühle on 21.01.2024.
//

import SwiftUI
import SwiftData
import TipKit

struct MoodAddView: View {
    @Query(sort: \Day.startedAt) var days: [Day]
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State var moodLevel: Double
    
    var getWord = MoodLevel.colorToWord
    var getColor = MoodLevel.valueToColor
    var batteryTip = BatteryTip()
    
    @State private var showFirework: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(moodLevel * 100, specifier: "%.0f")%")
                .font(.system(size: 56, weight: .black))
                .foregroundStyle(getColor(moodLevel))
            
            MoodBarometer(moodLevel: $moodLevel, levelColor: moodLevel)
                .frame(width: 250, height: 90)
                .padding()
                .popoverTip(batteryTip)
            
            Spacer()
            
            Text("\(getWord(getColor(moodLevel)))")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(getColor(moodLevel))
            
            Slider(value: $moodLevel, in: 0...1)
                .tint(getColor(moodLevel))
                .padding()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    saveMood()
                } label: {
                    Text("Save")
                }
                .disabled(moodLevel <= 0.01)
                .fontWeight(.semibold)
            }
        }
        .navigationTitle("Choose your Mood Level")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showFirework) {
            Firework()
        }
    }
    
    func saveMood() {
        let new = Mood(moodLevel: moodLevel)
        context.insert(new)
        
        markMoodDone()
        if moodLevel == 1 {
            showFirework.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8)) {
                dismiss()
            }
        } else {
            dismiss()
        }
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


