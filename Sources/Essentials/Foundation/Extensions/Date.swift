//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

//MARK: - Components

public extension Date {

    /// The year component of the date
    var year: Int? {
        Calendar.current.dateComponents([.year], from: self).year
    }

    /// The month component of the date
    var month: Int? {
        Calendar.current.dateComponents([.month], from: self).month
    }

    /// The coming month from the date
    var nextMonth: Date? {
        Calendar.current.date(byAdding: .month, value: 1, to: self)
    }

    /// The previous month from the date
    var previousMonth: Date? {
        Calendar.current.date(byAdding: .month, value: -1, to: self)
    }

    /// The start of day of the date's month
    var startOfMonth: Date? {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
    }

    /// The end of day of the date's month
    var endOfMonth: Date? {
        guard let start = startOfMonth else { return nil }
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: start)
    }

}
