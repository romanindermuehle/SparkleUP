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
    @State var weekdays: [(id: UUID, symbol: String)] = []
    @State var datesOfMonth: [CalendarDay] = []
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(weekdays, id: \.id) { key, value in
                Text(value)
                    .fontWeight(.bold)
            }
            
            ForEach(datesOfMonth, id: \.id) { day in
                DayView(date: day.date, isCompleted: isDayCompleted(for: day.date))
            }
        }
        .task {
            weekdays = getShortWeekdaySymbols()
            datesOfMonth = getDatesForCurrentMonth()
        }
    }
    
    func getShortWeekdaySymbols() -> [(UUID, String)] {
        let calendar = Calendar.current
        let symbols = calendar.veryShortWeekdaySymbols
        let firstWeekdayIndex = calendar.firstWeekday - 1
        let reorderedSymbols = Array(symbols[firstWeekdayIndex..<symbols.count] + symbols[0..<firstWeekdayIndex])
        
        var result: [(UUID, String)] = []
        
        for symbol in reorderedSymbols {
            let uuid = UUID()
            result.append((uuid, symbol))
        }
        
        return result
    }
    
    func getDatesForCurrentMonth(currentDate: Date = .now) -> [CalendarDay] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        
        guard let startOfMonth = calendar.date(from: components) else {
            return []
        }
        
        guard let range = calendar.range(of: .day, in: .month, for: startOfMonth) else {
            return []
        }
        
        var dates = range.compactMap { day -> CalendarDay? in
            guard let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) else {
                return nil
            }
            return CalendarDay(date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let leadingEmptyDays = (firstWeekday - calendar.firstWeekday + 7) % 7
        
        let placeholders = generatePlaceholders(count: leadingEmptyDays)
        
        dates.insert(contentsOf: placeholders, at: 0)
        
        return dates
    }
    
    func generatePlaceholders(count: Int) -> [CalendarDay] {
        var placeholders: [CalendarDay] = []
        
        for _ in 0..<count {
            placeholders.append(CalendarDay(date: Date.distantPast))
        }
        
        return placeholders
    }
    
    func isDayCompleted(for date: Date) -> Bool {
        days.contains { $0.startedAt.formatted(date: .abbreviated, time: .omitted) == date.formatted(date: .abbreviated, time: .omitted) && $0.percentage >= 1.0 }
    }
}


