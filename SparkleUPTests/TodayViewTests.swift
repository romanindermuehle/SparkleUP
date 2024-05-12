//
//  TodayViewTests.swift
//  SparkleUPTests
//
//  Created by Roman Indermühle on 10.05.2024.
//

import XCTest
@testable import SparkleUP

final class TodayViewTests: XCTestCase {

    func testOneDayDiffernce() {
        guard let currentDate = Date.createSpecificDate(year: 2024, month: 5, day: 10) else { return }
        guard let startedAt = Date.createSpecificDate(year: 2024, month: 5, day: 9) else { return }
        let todayView = TodayView()
        
        let days = todayView.checkDayOver(startedAt: startedAt, current: currentDate)

        XCTAssertEqual(days.count, 1)
        XCTAssertEqual(days.first?.startedAt.formatted(date: .numeric, time: .omitted), "5/10/2024")
    }
    
    func testFiveDayDiffernce() {
        guard let startedAt = Date.createSpecificDate(year: 2024, month: 5, day: 5) else { return }
        guard let currentDate = Date.createSpecificDate(year: 2024, month: 5, day: 10) else { return }
        
        let todayView = TodayView()
        
        let days = todayView.checkDayOver(startedAt: startedAt, current: currentDate)
        
        XCTAssertEqual(days.count, 5)
        XCTAssertFalse(days.last?.startedAt.formatted(date: .numeric, time: .omitted) == "5/5/2024")
        XCTAssertTrue(days.last?.startedAt.formatted(date: .numeric, time: .omitted) == "5/6/2024")
    }
    
    func testFiveDaysInFutureDiffernce() {
        guard let currentDate = Date.createSpecificDate(year: 2024, month: 5, day: 10) else { return }
        guard let startedAt = Date.createSpecificDate(year: 2024, month: 5, day: 15) else { return }
       
        let todayView = TodayView()
        
        let days = todayView.checkDayOver(startedAt: startedAt, current: currentDate)
        
        XCTAssertEqual(days.count, 1)
        XCTAssertFalse(days.last?.startedAt.formatted(date: .complete, time: .omitted) == "5/5/2024")
        XCTAssertTrue(days.last?.startedAt.formatted(date: .numeric, time: .omitted) == "5/10/2024")
    }
    
    func testSuccessfulCalculateDayDifference() {
        guard let currentDate = Date.createSpecificDate(year: 2024, month: 5, day: 10) else { return }
        guard let startedAt = Date.createSpecificDate(year: 2024, month: 5, day: 5) else { return }
       
        let todayView = TodayView()
        
        let numberOfDays = todayView.calculateDayDifference(fromDate: startedAt, toDate: currentDate)
        
       XCTAssertEqual(numberOfDays, 5)
    }
    
    func testNegativeCalculateDayDifference() {
        guard let currentDate = Date.createSpecificDate(year: 2024, month: 5, day: 5) else { return }
        guard let startedAt = Date.createSpecificDate(year: 2024, month: 5, day: 10) else { return }
       
        let todayView = TodayView()
        
        let numberOfDays = todayView.calculateDayDifference(fromDate: startedAt, toDate: currentDate)
        
       XCTAssertEqual(numberOfDays, -5)
    }
    
    func testSuccessfulSubtractDayFromDate() {
        guard let currentDate = Date.createSpecificDate(year: 2024, month: 5, day: 10) else { return }
        let numberOfDays = 5
       
        let todayView = TodayView()
        
        let subtractedDate = todayView.subtractDayFromDate(numberOfDays: numberOfDays, subtractFrom: currentDate)
        
        XCTAssertEqual(subtractedDate?.formatted(date: .numeric, time: .omitted), "5/5/2024")
    }
    
    func testNegativeSubtractDayFromDate() {
        guard let currentDate = Date.createSpecificDate(year: 2024, month: 5, day: 10) else { return }
        let numberOfDays = -5
       
        let todayView = TodayView()
        
        let subtractedDate = todayView.subtractDayFromDate(numberOfDays: numberOfDays, subtractFrom: currentDate)
        
        XCTAssertFalse(subtractedDate?.formatted(date: .numeric, time: .omitted) != "5/15/2024")
    }
}
