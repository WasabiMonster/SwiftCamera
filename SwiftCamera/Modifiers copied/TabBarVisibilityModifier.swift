//
//  TabBarVisibilityModifier.swift
//  Backflip
//
//  Created by Patrick Wilson on 5/28/22.
//

import SwiftUI
import Introspect

public struct TabBarVisibilityModifier: ViewModifier {
	var show: Bool

	public func body(content: Content) -> some View {
		content
			.introspectTabBarController { uiTabBarController in
				uiTabBarController.tabBar.isHidden = !show
				if show {
					NotificationCenter.default.post(name: Notification.notificationShowTabBar, object: nil)
				} else {
					NotificationCenter.default.post(name: Notification.notificationHideTabBar, object: nil)
				}
			}
	}
}

extension View {
	public func tabBarVisibility(_ show: Bool) -> some View {
		return self.modifier(TabBarVisibilityModifier(show: show))
	}
}
