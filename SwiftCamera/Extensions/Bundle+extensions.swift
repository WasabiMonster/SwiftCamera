//
//  Bundle+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 10/19/21.
//

import Foundation

extension Bundle {

    var name: String? {
        return object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    var appVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    var appBundleVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }

    public var backflipEnvironmentType: EnvironmentType {
        guard
            let envString = self.object(forInfoDictionaryKey: "BACKFLIP_ENV_TYPE") as? String,
            let environmentType = EnvironmentType(rawValue: envString)
        else {
            fatalError("Failed to determine current environment type")
        }
        return environmentType
    }
    
    public var branchKey: String? {
        return self.object(forInfoDictionaryKey: "branch_key") as? String
    }
    
    public var googleMapsKey: String? {
        return self.object(forInfoDictionaryKey: "google_maps_key") as? String
    }

	public var googleMapsProductionKey: String? {
		return self.object(forInfoDictionaryKey: "google_maps_production_key") as? String
	}

	public var segmentKey: String? {
		return self.object(forInfoDictionaryKey: "segment_key") as? String
	}

    public var sentryDSN: String {
        guard let sentryDSN = self.object(forInfoDictionaryKey: "SentryDSN") as? String else {
            fatalError("No value found for SentryDSN in plist")
        }
        return sentryDSN
    }
    
    public var sentryEnvironment: String {
        guard let sentryEnvironment = self.object(forInfoDictionaryKey: "SentryEnvironment") as? String else {
            fatalError("No value found for SentryEnvironment in plist")
        }
        return sentryEnvironment
    }
}
