//
//  Animation+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/8/21.
//

import SwiftUI

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
}
