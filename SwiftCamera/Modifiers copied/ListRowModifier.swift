//
//  ListRowModifier.swift
//  Backflip
//
//  Created by Patrick Wilson on 12/17/21.
//

import SwiftUI

struct ListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            Divider()
            content
        }
    }
}
