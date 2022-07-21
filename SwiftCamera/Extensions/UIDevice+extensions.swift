//
//  UIDevice+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 12/20/21.
//

import UIKit
import AudioToolbox

public extension UIDevice {

	/// Vibrations

    static func vibrateStandard() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }

    static func vibrateAlert() {
        AudioServicesPlaySystemSound(1011)
    }

    static func vibratePeek() {
        AudioServicesPlaySystemSound(1519)
    }
    
    static func vibratePop() {
        AudioServicesPlaySystemSound(1520)
    }

    static func vibrateCancelled() {
        AudioServicesPlaySystemSound(1521)
    }
    
    static func vibrateTryAgain() {
        AudioServicesPlaySystemSound(1102)
    }
    
    static func vibrateFailed() {
        AudioServicesPlaySystemSound(1107)
    }

	/// Device Characteristics

	var hasNotch: DeviceType {
		let keyWindow = UIApplication
			.shared
			.connectedScenes
			.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
			.first { $0.isKeyWindow }

		guard let keyWindow = keyWindow else { return .undetermined }
		if keyWindow.safeAreaInsets.top >= 44 {
			return .notch
		} else {
			return .noNotch
		}
	}
}

public enum DeviceType {
	case notch
	case noNotch
	case undetermined
}
