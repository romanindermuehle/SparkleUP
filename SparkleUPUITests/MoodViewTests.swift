//
//  MoodViewTests.swift
//  SparkleUPUITests
//
//  Created by Roman Indermühle on 11.05.2024.
//

import XCTest

final class MoodViewTests: XCTestCase {
    
    func testRecordNewMood() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Define your mood of the day"].tap()
        app.buttons["newMood"].tap()
        
        app.sliders["moodSlider"].adjust(toNormalizedSliderPosition: 0.5)
        
        app.buttons["Save"].tap()
        
        XCTAssertEqual(app.cells.count, 1)
    }
    
}
