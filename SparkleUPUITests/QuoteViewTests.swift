//
//  QuoteViewTests.swift
//  SparkleUPUITests
//
//  Created by Roman Indermühle on 11.05.2024.
//

import XCTest

final class QuoteViewTests: XCTestCase {

    func testQuoteSelection() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Let's Start"].tap()
        
        app.buttons["View your daily quote"].tap()
        app.buttons["rectangle.stack.badge.plus"].tap()
        
    }
}
