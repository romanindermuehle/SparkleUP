//
//  GratitudeViewTests.swift
//  SparkleUPTests
//
//  Created by Roman Indermühle on 11.05.2024.
//

import XCTest
@testable import SparkleUP

final class GratitudeViewTests: XCTestCase {

    func testSuccessfulCheckSequence() {
        let gratitudeView = GratitudeModifyView(gratitude: .constant(nil), gratitudeValue1: "", gratitudeValue2: "", gratitudeValue3: "", recordedInSequence: 0.0, isEditing: false)
        guard let dateMinusOne = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return }
        guard let dateMinusTwo = Calendar.current.date(byAdding: .day, value: -2, to: Date()) else { return }
        let date = Date()
        let days = [Day(tasksDone: ["gratitudeDone"], startedAt: dateMinusTwo), Day(tasksDone: ["gratitudeDone"], startedAt: dateMinusOne), Day(tasksDone: ["gratitudeDone"], startedAt: date)]
        
        let newSequenceNumber = gratitudeView.checkSequence(days: days, recordedInSequence: 0.0)
        
        XCTAssertEqual(newSequenceNumber, 1.0)
    }
    
    func testSuccessfulTwoCheckSequence() {
        let gratitudeView = GratitudeModifyView(gratitude: .constant(nil), gratitudeValue1: "", gratitudeValue2: "", gratitudeValue3: "", recordedInSequence: 0.0, isEditing: false)
        let date = Date()
        guard let dateMinusOne = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return }
        guard let dateMinusTwo = Calendar.current.date(byAdding: .day, value: -2, to: Date()) else { return }
        let days = [Day(startedAt: dateMinusTwo), Day(startedAt: dateMinusOne), Day(tasksDone: ["gratitudeDone"], startedAt: date)]
        
        let newSequenceNumber = gratitudeView.checkSequence(days: days, recordedInSequence: 0.0)
        
        XCTAssertEqual(newSequenceNumber, 1.0)
    }
    
    func testNegativeCheckSequence() {
        let gratitudeView = GratitudeModifyView(gratitude: .constant(nil), gratitudeValue1: "", gratitudeValue2: "", gratitudeValue3: "", recordedInSequence: 0.0, isEditing: false)
        let date = Date()
        guard let dateMinusOne = Calendar.current.date(byAdding: .day, value: -1, to: date) else { return }
        guard let dateMinusTwo = Calendar.current.date(byAdding: .day, value: -2, to: date) else { return }
        let days = [Day(tasksDone: ["gratitudeDone"], startedAt: dateMinusTwo), Day(startedAt: dateMinusOne), Day(tasksDone: ["gratitudeDone"], startedAt: date)]
        
        let newSequenceNumber = gratitudeView.checkSequence(days: days, recordedInSequence: 1.0)
        
        XCTAssertEqual(newSequenceNumber, 0.0)
    }
    
    func testNegativeTwoCheckSequence() {
        let gratitudeView = GratitudeModifyView(gratitude: .constant(nil), gratitudeValue1: "", gratitudeValue2: "", gratitudeValue3: "", recordedInSequence: 0.0, isEditing: false)
        let date = Date()
        guard let dateMinusOne = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return }
        let days = [Day(startedAt: dateMinusOne), Day(tasksDone: ["gratitudeDone"], startedAt: date), Day(tasksDone: ["gratitudeDone"], startedAt: date)]
        
        let newSequenceNumber = gratitudeView.checkSequence(days: days, recordedInSequence: 1.0)
        
        XCTAssertEqual(newSequenceNumber, 0.0)
    }
    
}
