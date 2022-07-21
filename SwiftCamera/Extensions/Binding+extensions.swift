//
//  Binding+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 1/30/22.
//
// https://www.swiftbysundell.com/articles/getting-the-most-out-of-xcode-previews/

import Foundation
import SwiftUI

extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
    
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
