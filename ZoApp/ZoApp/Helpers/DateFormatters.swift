//
//  DateFormatters.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let shared = DateHelper()
    
    private init() {}
    
    let dateFormatter = DateFormatter()
    
    func mediumDateSTRfromDouble(dateDouble: Double) -> String {
        let date = Date(timeIntervalSince1970: dateDouble)
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
//    func mediumStringForDateAndTime(date: Date) -> String {
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .medium
//        let dateString = dateFormatter.string(from: date)
//        return dateString
//    }
//
//    func mediumStringForTime(time: Date) -> String {
//        let newFormatter = DateFormatter()
//        newFormatter.dateFormat = "h:mm a"
//        let timeString = newFormatter.string(from: time)
//        return timeString
//    }
//
//    func mediumStringForDate(date: Date) -> String {
//        let newFormatter = DateFormatter()
//        newFormatter.dateFormat = "MMM. dd, yyyy"
//        let dateString = newFormatter.string(from: date)
//        return dateString
//    }
//
//    func dateFromString(strDate: String) -> String {
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.locale = Locale.current
//        let newFormatter = DateFormatter()
//        newFormatter.dateFormat = "MMM. dd, yyyy"
//        if let date = dateFormatter.date(from: strDate) {
//            return newFormatter.string(from: date)
//        } else {
//            return "No Date Available"
//        }
//    }
//
//    func timeFromString(strTime: String) -> String {
//        dateFormatter.dateFormat = "HH:mm:ss"
//        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: -3600)
//        dateFormatter.locale = Locale.current
//        let newFormatter = DateFormatter()
//        newFormatter.dateFormat = "h:mm a"
//        if let date = dateFormatter.date(from: strTime) {
//            return newFormatter.string(from: date)
//        } else {
//            return "No Time Available"
//        }
//    }
}
