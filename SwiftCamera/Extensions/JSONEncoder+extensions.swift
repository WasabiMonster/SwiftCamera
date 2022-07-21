//
//  JSONEncoder+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/16/21.
//

import Foundation

extension JSONEncoder {
    static let ZionAPI: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(DateFormatter.ZionAPI)
        return encoder
    }()
}
