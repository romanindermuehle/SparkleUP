//
//  CalendarView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 07.07.2024.
//

import SwiftUI

struct CalendarView: View {
    let days: [Day]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    @State var weekdays: [String] = []
    @State var datesOfMonth: [Date] = []
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(weekdays.indices, id: \.self) { index in
                Text(weekdays[index])
                    .fontWeight(.bold)
            }
            
            ForEach(datesOfMonth, id: \.self) { date in
                DayView(date: date, isCompleted: isDayCompleted(for: date))
            }
        }
        .onAppear {
            weekdays = getShortWeekdaySymbols()
            datesOfMonth = getDatesForCurrentMonth()
            
        }
    }
    
    func getShortWeekdaySymbols() -> [String] {
        let calendar = Calendar.current
        let symbols = calendar.veryShortWeekdaySymbols
        let firstWeekdayIndex = calendar.firstWeekday - 1
        return Array(symbols[firstWeekdayIndex..<symbols.count] + symbols[0..<firstWeekdayIndex])
    }
    
    func getDatesForCurrentMonth(currentDate: Date = .now) -> [Date] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        
        guard let startOfMonth = calendar.date(from: components) else {
            return []
        }
        
        guard let range = calendar.range(of: .day, in: .month, for: startOfMonth) else {
            return []
        }
        
        var dates = range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: startOfMonth) }
        
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let leadingEmptyDays = (firstWeekday - calendar.firstWeekday + 7) % 7
        
        dates.insert(contentsOf: Array(repeating: Date.distantPast, count: leadingEmptyDays), at: 0)
        
        return dates
    }
    
    func isDayCompleted(for date: Date) -> Bool {
        days.contains { $0.startedAt.formatted(date: .abbreviated, time: .omitted) == date.formatted(date: .abbreviated, time: .omitted) && $0.percentage >= 1.0 }
    }
}


