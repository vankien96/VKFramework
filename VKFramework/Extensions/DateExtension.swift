//
//  DateExtension.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation

struct Formatter {
    
    enum APIFormat: String {
        case date = "yyyy-MM-dd"
        case dateTime = "yyyy-MM-dd HH:mm:ss"
    }
    
    enum AppFormat: String {
        case date = "yyyy-MM-dd"
        case shortDate = "MM-dd"
        case longDate = "yyyy-MMM-dd"
        case dateTime = "yyyy-MM-dd HH:mm:ss"
        case dateTimeAndMilliseconds = "yyyy-MM-dd HH:mm:ss:SSS"
        case dotDate = "yyyy.MM.dd"
        case hourMinute = "HH:mm"
        case dateTimeWithoutSecond = "yyyy-MM-dd HH:mm"
        case day = "dd"
        case month = "MM"
    }
    
    static func defaultCalendar() -> Calendar {
        return Calendar(identifier: .gregorian)
    }
    
    static func defaultLocale() -> Locale {
        return Locale(identifier: "en_US_POSIX")
    }
    
    static let `default`: DateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.calendar = Formatter.defaultCalendar()
        formatter.locale = Formatter.defaultLocale()
        formatter.dateFormat = APIFormat.dateTime.rawValue
        return formatter
    }()
    
    static let dateOnly: DateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.calendar = Formatter.defaultCalendar()
        formatter.locale = Formatter.defaultLocale()
        formatter.dateFormat = APIFormat.date.rawValue
        return formatter
    }()
    
    static let timeOnly: DateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.calendar = Formatter.defaultCalendar()
        formatter.locale = Formatter.defaultLocale()
        formatter.dateFormat = AppFormat.hourMinute.rawValue
        return formatter
    }()
    
    static func formatter(dateFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Formatter.defaultCalendar()
        formatter.locale = Locale.current
        formatter.dateFormat = dateFormat
        return formatter
    }
}

extension Date {
    
    func toTimestampSecond() -> UInt64 {
        return UInt64(self.timeIntervalSince1970)
    }
}
