//
//  DismissingKeyboard.swift
//  Backflip
//
//  Created by Patrick Wilson on 3/17/22.
//

import SwiftUI

struct DismissingKeyboard: ViewModifier {
    let action: ModifierCallback?
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                .onEnded({ value in
                    if value.translation.width < 0 {
                        // left
                    }
                    if value.translation.width > 0 {
                        // right
                    }
                    if value.translation.height < 0 {
                        // up
                    }
                    if value.translation.height > 0 {
                        let keyWindow = UIApplication.shared.connectedScenes
                            .filter({ $0.activationState == .foregroundActive })
                            .map({ $0 as? UIWindowScene })
                            .compactMap({ $0 })
                            .first?.windows
                            .filter({ $0.isKeyWindow }).first
                        keyWindow?.endEditing(true)
                        action?()
                    }
                }))
            /* .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .map({ $0 as? UIWindowScene })
                    .compactMap({ $0 })
                    .first?.windows
                    .filter({ $0.isKeyWindow }).first
                keyWindow?.endEditing(true)
                action()
            } */
    }
}

extension View {
	public func dismissingKeyboard(action: @escaping () -> () = {}) -> some View {
		return self.modifier(DismissingKeyboard(action: action))
	}
}
