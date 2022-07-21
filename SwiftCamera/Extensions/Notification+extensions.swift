//
//  Notification+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 3/20/22.
//

import Foundation

extension Notification {
    static let notificationForceLogout = Notification.Name.init("forceLogout")
    static let notificationAppMessage = Notification.Name.init("appMessage")
	static let notificationHideTabBar = Notification.Name.init("notificationHideTabBar")
	static let notificationShowTabBar = Notification.Name.init("notificationShowTabBar")
}
