//
//  Browsing.swift
//  Backflip
//
//  Created by Patrick Wilson on 5/3/22.
//

import SwiftUI

extension View {
	func requiresAuth(
		isAuthenticated: Bool,
		onComplete: @escaping ViewCallback
	) -> ViewCallback? {
		if isAuthenticated {
			onComplete()
			return nil
		} else {
			return onComplete
		}
	}

	func browsingModifier(_ browsingInfo: AuthenticationCTA) -> some View {
		modifier(BrowsingModifier(browsingInfo))
	}

	func authFirstSheet(
		isPresented: Binding<Bool>,
		_ browsingInfo: AuthenticationCTA,
		onClose: ViewCallback? = nil,
		onComplete: @escaping ViewCallback
	) -> some View {
		modifier(
			AuthFirstSheetModifier(
				isPresented: isPresented,
				browsingInfo,
				onClose: onClose,
				onComplete: onComplete
			)
		)
	}
}

struct BrowsingModifier: ViewModifier {
	@EnvironmentObject var appContext: AppContext
	@State private var isPresented = false

	let authCTA: AuthenticationCTA

	@State private var showPrivacyWebView = false

	init(_ browsingInfo: AuthenticationCTA) {
		self.authCTA = browsingInfo
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

				if authCTA == .account {
					Button {
						showPrivacyWebView.toggle()
					} label: {
						Text("VIEW OUR PRIVACY POLICY")
							.customFont(AppFonts.primaryDisplay, category: .medium)
							.foregroundColor(Color.tertiaryTeal)
							.padding(.top, 12)
					}
				}

				Spacer()

				RoundedCTAButton(labelStr: "Log in or Sign up") {
					isPresented = true
				}
				.padding(.bottom, 42)
			}
			.sheet(isPresented: $showPrivacyWebView) {
				if let url = URL(string: "\(Environ.current.webAddress)privacy/?appDisplay=true") {
					WebView(url: url)
				}
			}
			.authFirstSheet(isPresented: $isPresented, self.authCTA, onComplete: {})
		} else {
			content
		}
	}
}

struct AuthFirstSheetModifier: ViewModifier {
	@EnvironmentObject var appContext: AppContext
	@Binding var isPresented: Bool

	let authCTA: AuthenticationCTA
	var onClose: ModifierCallback?
	let onComplete: ModifierCallback

	init(
		isPresented: Binding<Bool>,
		_ browsingInfo: AuthenticationCTA,
		onClose: ModifierCallback? = nil,
		onComplete: @escaping () -> Void
	) {
		self._isPresented = isPresented
		self.authCTA = browsingInfo
		self.onClose = onClose
		self.onComplete = onComplete
	}

	func body(content: Content) -> some View {
		content
			.sheet(isPresented: $isPresented) {
				ZStack {
					InitialView(
						authCTA: self.authCTA,
						onAuth: {
							self.closeModal()
							self.onComplete()
						}
					)

					Button {
						self.closeModal()
					} label: {
						CloseCoverImage()
					}
					.padding(.trailing, 20)
					.position(x: 36, y: 75)
				}
				.frame(maxHeight: .infinity)
			}
			.interactiveDismissDisabled(false)
	}

	private func closeModal() {
		isPresented = false
		self.onClose?()
	}
}
