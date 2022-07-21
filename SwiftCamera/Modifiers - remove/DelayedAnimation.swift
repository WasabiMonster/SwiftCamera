//
//  DelayedAnimation.swift
//  Backflip
//
//  Created by Patrick Wilson on 12/20/21.
//

import SwiftUI

struct DelayedAnimation: ViewModifier {
    var delay: Double
    var animation: Animation
    
    @State private var animating = false
    
    func delayAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.animating = true
        }
    }
    
    func body(content: Content) -> some View {
        content
            .animation(animating ? animation : nil, value: self.animating)
            .onAppear(perform: delayAnimation)
    }
}

extension View {
    func delayedAnimation(delay: Double = 1.0, animation: Animation = .default) -> some View {
        self.modifier(DelayedAnimation(delay: delay, animation: animation))
    }
}
