//
//  Date.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 10.05.2024.
//

import Foundation

extension Date {
    static func createSpecificDate(year: Int, month: Int, day: Int) -> Date? {
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = .current
        dateComponents.hour = 9
        dateComponents.minute = 41

        // Create date from components
        let userCalendar = Calendar(identifier: Calendar.current.identifier) // since the components above (like year 1980) are for Gregorian
        return userCalendar.date(from: dateComponents)
    }
}
