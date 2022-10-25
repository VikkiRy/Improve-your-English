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
    
    var startOfWeek: Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: .now)
        dateComponents.timeZone = TimeZone.init(abbreviation: "UTC")
        let sunday = calendar.date(from: dateComponents)!
        
        return calendar.date(byAdding: .day, value: 1, to: sunday)!
    }
    
    var endOfWeek: Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: .now)
        dateComponents.timeZone = TimeZone.init(abbreviation: "UTC")
        let sunday = calendar.date(from: dateComponents)!
        
        return calendar.date(byAdding: .day, value: 7, to: sunday)!
    }
    
    var startOfMonth: Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month], from: .now)
        dateComponents.timeZone = TimeZone.init(abbreviation: "UTC")
        
        return  calendar.date(from: dateComponents)!
        }
    
    var startOfYear: Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year], from: .now)
        dateComponents.timeZone = TimeZone.init(abbreviation: "UTC")
        
        let startOfYear = calendar.date(from: dateComponents)!
        dateComponents.year = 0
        dateComponents.day = 0
        
        return calendar.date(byAdding: dateComponents, to: startOfYear)!
    }
}
