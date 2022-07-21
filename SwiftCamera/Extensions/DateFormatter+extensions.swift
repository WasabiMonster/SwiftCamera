//
//  DateFormatter+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/16/21.
//

import Foundation

extension DateFormatter {
    /// Parses dates according to the format used by the Zion API
    static let ZionAPI: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ" // 01/07/2022 21:33:27.461741
        return formatter
    }()
    
    /// Basic date-only format, used in property record valuation response
    static let ValuationsAPISpace: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    /// Another format thats returned from updated_at and created_at fields
    static let ZionAPI2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss.SSSSSS"
        return formatter
    }()

    /// Another format that's used for 'date_sold' on comps and ''target_close_date" on Loans
    /// convertDateToMMDDYYYYString in JS web app
    static let ZionAPI3: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    static func tryAllFormatters(dateString: String) -> Date? {
        let formatters = [ZionAPI, ZionAPI2, ZionAPI3, ValuationsAPISpace]
        for formatter in formatters {
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        return nil
    }
    
    // May not be needed ever
    func dateFromMultipleFormats(fromString dateString: String) -> Date? {
         let formats: [String] = [
         "yyyy-MM-dd hh:mm:ss.SSSSxx",
         "yyyy-MM-dd hh:mm:ss.SSSxxx",
         "yyyy-MM-dd hh:mm:ss.SSxxxx",
         "yyyy-MM-dd hh:mm:ss.Sxxxxx",
         "yyyy-MM-dd hh:mm:ss"
         ]
     for format in formats {
         self.dateFormat = format
         if let date = self.date(from: dateString) {
                 return date
             }
         }
         return nil
     }
}
