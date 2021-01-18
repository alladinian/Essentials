//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

//MARK: - Components

public extension Date {

    var year: Int? {
        Calendar.current.dateComponents([.year], from: self).year
    }

    var month: Int? {
        Calendar.current.dateComponents([.month], from: self).month
    }

    var nextMonth: Date? {
        Calendar.current.date(byAdding: .month, value: 1, to: self)
    }

    var previousMonth: Date? {
        Calendar.current.date(byAdding: .month, value: -1, to: self)
    }

    var startOfMonth: Date? {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
    }

    var endOfMonth: Date? {
        guard let start = startOfMonth else { return nil }
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: start)
    }

}
