//
//  AuthFirstModifier.swift
//  Backflip
//
//  Created by Patrick Wilson on 5/3/22.
//
// 	To be used on buttons that require authentication before action

/*
import SwiftUI

extension View {
	func authFirstModifier(_ browsingInfo: AuthenticationCTA, onComplete: @escaping ViewCallback) -> some View {
		modifier(AuthFirstModifier(browsingInfo, onComplete))
	}
}
struct AuthFirstModifier: ViewModifier {
	@EnvironmentObject var appContext: AppContext
	@State private var isPresented = false

	let authCTA: AuthenticationCTA
	let onComplete: ModifierCallback

	init(_ browsingInfo: AuthenticationCTA, _ onComplete: @escaping () -> Void) {
		self.authCTA = browsingInfo
		self.onComplete = onComplete
	}

	func body(content: Content) -> some View {
		if appContext.userIsBrowsing {
			VStack {
				Spacer()

				if let header = authCTA.header {
					Text(header)
						.customFont(AppFonts.primaryHeadline, category: .large)
						.multilineTextAlignment(.center)
						.foregroundColor(Color.primaryDarkGreen)
						.padding(.horizontal, 42)
						.padding(.bottom, 42)
						.transition(AnyTransition.opacity.animation(.linear(duration: 0.25)))
				}

				Text(authCTA.longDesc)
					.customFont(AppFonts.primaryDisplay, category: .medium)
					.multilineTextAlignment(.center)
					.lineSpacing(3.4)
					.foregroundColor(Color.primaryGreen)
					.padding(.horizontal, 42)
					.transition(AnyTransition.opacity.animation(.linear(duration: 0.25)))

				Spacer()

				RoundedCTAButton(labelStr: "Log in or Sign up") {
					isPresented = true
				}
				.padding(.bottom, 42)
			}
			.sheet(isPresented: $isPresented) {
				ZStack {
					InitialView(authCTA: self.authCTA)

					Button {
						isPresented = false
					} label: {
						CloseCoverImage()
					}
					.padding(.trailing, 20)
					.position(x: 36, y: 75)
				}
				.frame(maxHeight: .infinity)
			}
		} else {
			content
		}
	}
}
*/
