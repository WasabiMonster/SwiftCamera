//
//  NavigationBarModifier.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/20/22.
//

import SwiftUI
import Introspect

struct NavigationBarModifier: ViewModifier {
    @State var nav: UINavigationController?
    var backgroundColor: UIColor?

    @State var navType: NavType
    
    init(backgroundColor: UIColor?, navType: NavType) {
        self.navType = navType
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content

            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
            .navigationBarHidden(false)
        }
        .introspectNavigationController { nav in
            self.nav = nav
            updateNavBar()
        }
        .onAppear {
            updateNavBar()
        }
    }
    
    private func updateNavBar() {
        let appearance = UINavigationBarAppearance()
		appearance.configureWithTransparentBackground()
		appearance.backgroundColor = backgroundColor
		appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        let compactAppearance = UINavigationBarAppearance()
		compactAppearance.configureWithTransparentBackground()
        compactAppearance.backgroundColor = backgroundColor // UIColor(Color.white)

        UINavigationBar.appearance().standardAppearance = appearance
		UINavigationBar.appearance().compactAppearance = compactAppearance

        if navType == .compact {
			UINavigationBar.appearance().compactAppearance = compactAppearance

			UINavigationBar.appearance().compactAppearance = appearance
			UINavigationBar.appearance().scrollEdgeAppearance = appearance
		} else {
			UINavigationBar.appearance().compactAppearance = appearance
			UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }

        guard let nav = nav else { return }

        nav.navigationBar.standardAppearance = appearance
		nav.navigationBar.compactAppearance = compactAppearance

        if navType == .compact {
			nav.navigationBar.compactAppearance = compactAppearance

			nav.navigationBar.compactAppearance = appearance
			nav.navigationBar.scrollEdgeAppearance = appearance
        } else {
			nav.navigationBar.compactAppearance = appearance
			nav.navigationBar.scrollEdgeAppearance = appearance
        }
    }
}

enum NavType: String {
    case standard = "standard green"
    case transparent = "custom transparent"
    case compact = "compact only"
}

extension View {
    func navigationBarModifier(backgroundColor: UIColor?, navType: NavType) -> some View {
        return self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, navType: navType))
    }
}
