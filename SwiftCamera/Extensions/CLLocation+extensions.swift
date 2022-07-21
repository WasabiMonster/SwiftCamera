//
//  CLLocation+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/9/21.
//

import Foundation
import CoreLocation

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}

extension CLAuthorizationStatus {
	var description: String {
		switch self {

		case .notDetermined:
			return "notDetermined"
		case .restricted:
			return "restricted"
		case .denied:
			return "denied"
		case .authorizedAlways:
			return "authorizedAlways"
		case .authorizedWhenInUse:
			return "authorizedWhenInUse"
		@unknown default:
			return "unknown"
		}
	}
}
