//
//  Event+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 3/20/22.
//
//	Graduallly deprecating Sentry

import Foundation
import Sentry

typealias SentryEvent = Sentry.Event
// typealias FirebaseEvent = Fire.Event

/// We generally use custom Sentry events as the opposite of errors.
/// Where an error represents a process that ended in failure, an event
/// represents a process that ended successfully.
/// https://docs.sentry.io/clients/cocoa/advanced/
extension SentryEvent {
    
    // MARK: - Initialization

    static func event(withLevel level: SentryLevel, message: String) -> SentryEvent {
        let event = SentryEvent()
        event.level = level
        event.message = SentryMessage(formatted: message)
        return event
    }
}

// MARK: - Authentication

extension SentryEvent {
    
    static func noStoredUser() -> SentryEvent {
        return SentryEvent.event(withLevel: .info, message: "No stored User")
    }
    
    static func authenticatedUser() -> SentryEvent {
        return SentryEvent.event(withLevel: .info, message: "Authenticated User")
    }

	static func forceLogoutNotification() -> SentryEvent {
		return SentryEvent.event(withLevel: .info, message: "User Forced to Logout on 401 Response")
	}

    static func logoutUser() -> SentryEvent {
        return SentryEvent.event(withLevel: .info, message: "Logout User")
    }

	static func deleteUserAccount() -> SentryEvent {
		return SentryEvent.event(withLevel: .info, message: "User Account Deleted :(")
	}

    static func branchUserAlreadyAuthenticated() -> SentryEvent {
        return SentryEvent.event(withLevel: .info, message: "User is already authenticated")
    }
}
