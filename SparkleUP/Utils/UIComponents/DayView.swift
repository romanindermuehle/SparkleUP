//
//  DayView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 15.07.2024.
//

import SwiftUI

struct DayView: View {
    let date: Date
    let isCompleted: Bool
    
    var body: some View {
        if Calendar.current.isDate(date, equalTo: Date.distantPast, toGranularity: .day) {
            Color.clear
                .frame(width: 40, height: 40)
        } else {
            Text(dayString)
                .fontWeight(.bold)
                .frame(width: 40, height: 40)
                .foregroundStyle(.white)
                .background(isCompleted ? .lightMagenta : Color(.systemGray4))
                .clipShape(Circle())
        }
    }
    
    private var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}
