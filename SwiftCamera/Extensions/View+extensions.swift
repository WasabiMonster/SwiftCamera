//
//  View+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 1/30/22.
//

import Foundation
import SwiftUI
import UIKit

// MARK: - Callbacks
extension View {
    public typealias ViewCallback = () -> Void
    typealias CallbackWithLoan = (Loan) -> Void
    typealias CallbackWithAnalysis = (Analyzer) -> Void
    typealias CallbackWithModel = (Codable) -> Void
	typealias CallbackWithComps = ([CompProperty]) -> Void
	typealias CallbackWithInt = (Int) -> Void
    typealias CallbackWithString = (String) -> Void
    typealias CallbackWithAutocomplete = (AutocompleteResult) -> Void
	typealias CallbackWithInputType = (InputType) -> Void
	typealias CallbackWithPurpose = (WelcomePurpose) -> Void
    typealias CallbackWithURL = (URL) -> Void
}

// MARK: - If modifier
extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Shapes
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// MARK: - Geometry Reading
extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

// MARK: - Notification Center
extension View {
    func onNotification(_ name: Notification.Name, perform action: @escaping (Notification) -> Void) -> some View {
        onAppear {
            NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { notification in
                action(notification)
            }
        }
    }

}

// MARK: - Gestures
extension View {
    func onTouchDownGesture(callback: @escaping () -> Void) -> some View {
        modifier(OnTouchDownGestureModifier(callback: callback))
    }
}

private struct OnTouchDownGestureModifier: ViewModifier {
    @State private var tapped = false
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !self.tapped {
                        self.tapped = true
                        self.callback()
                    }
                }
                .onEnded { _ in
                    self.tapped = false
                })
    }
}

// MARK: - Screenshot Sharing - deprecate?
extension View {
    func onScreenshot(stateVar: Binding<Bool>) -> some View {
        onNotification(UIApplication.userDidTakeScreenshotNotification) { _ in
            self.screenshotTaken(stateVar: stateVar)
            // self.popover(isPresented: stateVar)
        }
    }

    func screenshotTaken(stateVar: Binding<Bool>) {
        stateVar.wrappedValue = true
        /* DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            stateVar.wrappedValue = false
        } */
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// MARK: - Redaction
extension View {
	@ViewBuilder
	func redacted(if condition: @autoclosure () -> Bool) -> some View {
		redacted(reason: condition() ? .placeholder : [])
	}
}

// MARK: - Frame management
extension View {
	public func frameGetter(_ frame: Binding<CGRect>, _ safeArea: Binding<EdgeInsets> = .constant(EdgeInsets())) -> some View {
		modifier(FrameGetter(frame: frame, safeArea: safeArea))
	}
}

struct FrameGetter: ViewModifier {

	@Binding var frame: CGRect
	@Binding var safeArea: EdgeInsets

	func body(content: Content) -> some View {
		content
			.background(
				GeometryReader { proxy -> AnyView in
					let rect = proxy.frame(in: .global)
					// This avoids an infinite layout loop
					if rect.integral != self.frame.integral {
						DispatchQueue.main.async {
							self.safeArea = proxy.safeAreaInsets
							self.frame = rect
						}
					}
					return AnyView(EmptyView())
				}
			)
	}
}

// MARK: - Keyboard
#if canImport(UIKit)
extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
#endif
