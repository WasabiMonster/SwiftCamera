//
//  AnimatableModifierCGFloat.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/9/21.
//

import SwiftUI

struct AnimatableModifierCGFloat: ViewModifier, Animatable {

    var targetValue: CGFloat

    var animatableData: CGFloat {
        didSet {
            checkIfFinished()
        }
    }

    var completion: () -> Void

    // Re-created every time the control argument changes
    init(bindedValue: CGFloat, completion: @escaping () -> Void) {
        self.completion = completion

        // Set animatableData to the new value. But SwiftUI again directly
        // and gradually varies the value while the body
        // is being called to animate. Following line serves the purpose of
        // associating the extenal argument with the animatableData.
        self.animatableData = bindedValue
        targetValue = bindedValue
    }

    func checkIfFinished() {
        // print("Current value: \(animatableData)")
        if animatableData == targetValue {
            // if animatableData.isEqual(to: targetValue) {
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }

    // Called after each gradual change in animatableData to allow the
    // modifier to animate
    func body(content: Content) -> some View {
        // content is the view on which .modifier is applied
        content
        // We don't want the system also to
        // implicitly animate default system animatons it each time we set it. It will also cancel
        // out other implicit animations now present on the content.
            .animation(nil)
    }
}
