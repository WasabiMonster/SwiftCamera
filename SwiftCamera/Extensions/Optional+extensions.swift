//
//  Optional+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/23/21.
//

import Foundation

extension Optional {
    var loggable: Any {
        switch self {
        case .none:
            return "⭕️"
        case let .some(value):
            return value
        }
    }
}

protocol OptionalProtocol {
  // the metatype value for the wrapped type.
  static var wrappedType: Any.Type { get }
}

extension Optional: OptionalProtocol {
  static var wrappedType: Any.Type { return Wrapped.self }
    
    static func isOptionalType(_ type: Any.Type) -> Bool {
        return type is OptionalProtocol.Type
    }
}
