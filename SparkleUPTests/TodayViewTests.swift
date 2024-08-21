//
//  TodayViewTests.swift
//  SparkleUPTests
//
//  Created by Roman Indermühle on 10.05.2024.
//

import XCTest
@testable import SparkleUP

final class TodayViewTests: XCTestCase {

    func testNewDaySuccessful() {
        let days: [Day] = [Day(startedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()), Day(startedAt: Date.now)]
        let previousStreakCount: Int = Streak(count: 1, lastUpdated: nil).count
        let todayView = TodayView()
        
        let newDay = todayView.createNewDay(days: days, previousStreakCount: previousStreakCount)

        XCTAssertNil(newDay)
    }
    
    func testNewDayNegative() {
        let days: [Day] = [Day(startedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())]
        let previousStreakCount: Int = Streak(count: 0, lastUpdated: nil).count
        let todayView = TodayView()
        
        let newDay = todayView.createNewDay(days: days, previousStreakCount: previousStreakCount)

        XCTAssertEqual(newDay?.day.startedAt.formatted(date: .abbreviated, time: .omitted), Date().formatted(date: .abbreviated, time: .omitted))
        XCTAssertEqual(newDay?.streak.addedAt.formatted(date: .abbreviated, time: .omitted), Date().formatted(date: .abbreviated, time: .omitted))
    }
}
