//
//  Date+.swift
//  
//
//  Created by gnksbm on 10/7/24.
//

import Foundation

public extension Date {
    var relativeFormat: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .short
        let dateToString = formatter.localizedString(
            for: self,
            relativeTo: Date()
        )
        return dateToString
    }
}
