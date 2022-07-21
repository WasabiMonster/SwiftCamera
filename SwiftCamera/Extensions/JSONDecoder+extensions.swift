//
//  JSONDecoder+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/16/21.
//

import Foundation

extension JSONDecoder {
    static let ZionAPI: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.ZionAPI)
        return decoder
    }()
}
