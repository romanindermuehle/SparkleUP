//
//  ProgressViewTests.swift
//  SparkleUPTests
//
//  Created by Roman Indermühle on 16.07.2024.
//

import XCTest
@testable import SparkleUP

final class ProgressViewTests: XCTestCase {
    func testCheckStreakSuccessful() {
        let progressView = ProgressView()
        let lastStreak = Streak(count: 1, addedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), lastUpdated: Calendar.current.date(byAdding: .day, value: -1, to: Date())).count
        let streak = Streak(count: 0, addedAt: Date(), lastUpdated: nil)
        let days = [Day(percentage: 1.0, startedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()), Day(percentage: 1.0, startedAt: Date())]
        
        
        let checkStreak = progressView.checkStreak(streak: streak, lastStreakCount: lastStreak, days: days)
        
        XCTAssertEqual(checkStreak, 2)
    }
    
    func testCheckStreakSuccessfulTwo() {
        let progressView = ProgressView()
        let lastStreak = Streak(count: 0, addedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), lastUpdated: Calendar.current.date(byAdding: .day, value: -1, to: Date())).count
        let streak = Streak(count: 0, addedAt: Date(), lastUpdated: nil)
        let days = [Day(percentage: 0.0, startedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()), Day(percentage: 1.0, startedAt: Date())]
        
        
        let checkStreak = progressView.checkStreak(streak: streak, lastStreakCount: lastStreak, days: days)
        
        XCTAssertEqual(checkStreak, 1)
    }
    
    func testCheckStreakNegative() {
        let progressView = ProgressView()
        let lastStreak = Streak(count: 0, addedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), lastUpdated: Calendar.current.date(byAdding: .day, value: -1, to: Date())).count
        let streak = Streak(count: 0, addedAt: Date(), lastUpdated: nil)
        let days = [Day(percentage: 0.0, startedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()), Day(percentage: 0.0, startedAt: Date())]
        
        
        let checkStreak = progressView.checkStreak(streak: streak, lastStreakCount: lastStreak, days: days)
        
        XCTAssertEqual(checkStreak, nil)
    }
    
    func testCheckStreakNegativeTwo() {
        let progressView = ProgressView()
        let lastStreak = Streak(count: 0, addedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), lastUpdated: Calendar.current.date(byAdding: .day, value: -1, to: Date())).count
        let streak = Streak(count: 0, addedAt: Date(), lastUpdated: nil)
        let days = [Day(percentage: 1.0, startedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()), Day(percentage: 0.0, startedAt: Date())]
        
        
        let checkStreak = progressView.checkStreak(streak: streak, lastStreakCount: lastStreak, days: days)
        
        XCTAssertEqual(checkStreak, nil)
    }
    
    func testGetShortWeekdaySymbols() {
        let days = [Day(percentage: 1.0, startedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()), Day(percentage: 0.0, startedAt: Date())]
        
        let calenderView = CalendarView(days: days)
        
        let getShortWeekdaySymbols = calenderView.getShortWeekdaySymbols()
        
        XCTAssertEqual(getShortWeekdaySymbols, ["M", "T", "W", "T", "F", "S", "S"])
    }
    
    func testGetDatesForFebruary() {
        let days = [Day(percentage: 1.0, startedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()), Day(percentage: 0.0, startedAt: Date())]
        
        let calenderView = CalendarView(days: days)
        guard let februaryDate = DateComponents(calendar: Calendar.current, year: 2024, month: 2, day: 10).date else { return }
        
        let getDatesForCurrentMonth = calenderView.getDatesForCurrentMonth(currentDate: februaryDate)
        
        // February has only 29 days and the month started on Thursday. So for the UI we need to fill the empty space. In this case 3 days. They are called leadingDays.
        XCTAssertEqual(getDatesForCurrentMonth.count, 32)
        
        
    }
    
    func testGetDatesForJuly() {
        let days = [Day(percentage: 1.0, startedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()), Day(percentage: 0.0, startedAt: Date())]
        
        let calenderView = CalendarView(days: days)
        guard let julyDate = DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 10).date else { return }
        
        let getDatesForCurrentMonth = calenderView.getDatesForCurrentMonth(currentDate: julyDate)
        
        XCTAssertEqual(getDatesForCurrentMonth.count, 31)
        
        
    }
    
    func testGetDatesForNovember() {
        let days = [Day(percentage: 1.0, startedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()), Day(percentage: 0.0, startedAt: Date())]
        
        let calenderView = CalendarView(days: days)
        guard let novemberDate = DateComponents(calendar: Calendar.current, year: 2024, month: 11, day: 10).date else { return }
        
        let getDatesForCurrentMonth = calenderView.getDatesForCurrentMonth(currentDate: novemberDate)
        
        // There are 30 days in November and the month starts on Friday. So for the UI we need to fill the empty space. In this case 4 days. They are called leadingDays.
        XCTAssertEqual(getDatesForCurrentMonth.count, 34)
        
        
    }
    
    func testIsDayCompletedSuccessful() {
        guard let specificDate = DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 7).date else { return }
        guard let specificDateTwo = DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 8).date else { return }
        let days = [Day(percentage: 1.0, startedAt: specificDate), Day(percentage: 1.0, startedAt: specificDateTwo)]
        
        let calenderView = CalendarView(days: days)
        guard let checkDate = DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 8).date else { return }
        let isDayCompleted = calenderView.isDayCompleted(for: checkDate)
        
        XCTAssertTrue(isDayCompleted)
        
    }
    
    func testIsDayCompletedNegative() {
        guard let specificDate = DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 7).date else { return }
        guard let specificDateTwo = DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 8).date else { return }
        let days = [Day(percentage: 1.0, startedAt: specificDate), Day(percentage: 0.0, startedAt: specificDateTwo)]
        
        let calenderView = CalendarView(days: days)
        guard let checkDate = DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 8).date else { return }
        let isDayCompleted = calenderView.isDayCompleted(for: checkDate)
        
        XCTAssertFalse(isDayCompleted)
    }
    
}
