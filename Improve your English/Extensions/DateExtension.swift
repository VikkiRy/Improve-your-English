//
//  FoundationExtensions.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/10/2022.
//

import Foundation

extension Date {
    var currentDay: Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: .now)
        dateComponents.timeZone = TimeZone.init(abbreviation: "UTC")
        
        return calendar.date(from: dateComponents)!
    }
}
