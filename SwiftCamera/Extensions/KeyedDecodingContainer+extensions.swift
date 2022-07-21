//
//  KeyedDecodingContainer+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 1/6/22.
//
//  Ensures dates get decoded to formats received
//  by the Backflip backend

import Foundation

private struct DateWrapper: Decodable {
    var date: Date?

    private enum TimeCodingKeys: String, CodingKey {
        case datetime
    }

    init(from decoder: Decoder) throws {
        var dateString: String
        if let timeContainer = try? decoder.container(keyedBy: TimeCodingKeys.self) {
            dateString = try timeContainer.decode(String.self, forKey: .datetime)
        } else {
            let container = try decoder.singleValueContainer()
            if let string = try? container.decode(String.self) {
                dateString = string
            } else {
                self.date = nil
                return
            }
        }

        dateString = dateString.replacingOccurrences(of: "/", with: "-")
        
        if let date = DateFormatter.tryAllFormatters(dateString: dateString) {
            self.date = date
        } else if dateString == "null" {
            self.date = nil
        } else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Date format was not parseable.")
            throw DecodingError.dataCorrupted(context)
        }
    }
}

extension KeyedDecodingContainer {

    func decode(_ type: Date.Type, forKey key: K) throws -> Date? {
        return try self.decode(DateWrapper.self, forKey: key).date
    }

    // Array
    func decode(_ type: [Date].Type, forKey key: K) throws -> [Date] {
        var container = try nestedUnkeyedContainer(forKey: key)
        var dates: [Date] = []
        while !container.isAtEnd {
            dates.append(try container.decode(Date.self))
        }
        return dates
    }

    func decodeIfPresent(_ type: Date.Type, forKey key: K) throws -> Date? {
        guard contains(key) else {
            return nil
        }
        return try decode(DateWrapper.self, forKey: key).date
    }

    // Array
    func decodeIfPresent(_ type: [Date].Type, forKey key: K) throws -> [Date] {
        guard contains(key) else {
            return []
        }
        return try decode([Date].self, forKey: key)
    }
}

extension UnkeyedDecodingContainer {

    // This hits all dates that are decoded in models throughout the app
    mutating func decode(_ type: Date.Type) throws -> Date? {
        return try self.decode(DateWrapper.self).date
    }

}
