//
//  AnimatableModifierDouble.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/9/21.
//

import Foundation
import SwiftUI

struct AnimatableModifierDouble: ViewModifier, Animatable {

    var targetValue: Double

    var animatableData: Double {
        didSet {
            checkIfFinished()
        }
    }

    var completion: () -> Void

    // Re-created every time the control argument changes
    init(bindedValue: Double, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = bindedValue
        targetValue = bindedValue
    }

    func checkIfFinished() {
        if animatableData == targetValue {
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }

    func body(content: Content) -> some View {
        content
            .animation(nil)
    }
}
