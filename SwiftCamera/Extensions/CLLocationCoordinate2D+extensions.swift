//
//  CLLocationCoordinate2D+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 12/31/21.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    // Calculate the distance between two coordinates
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
        return from.distance(from: to)
    }

    // Calculate the bearing between two coordinates
    /* func bearing(to: CLLocationCoordinate2D) -> Double {
        let from = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.bearing(to: to)
    }

    // Calculate the coordinate at a certain distance and bearing from this coordinate
    func coordinate(atDistance: CLLocationDistance, atBearing: Double) -> CLLocationCoordinate2D {
        let distance = atDistance / 6371000.0
        let bearing = atBearing.toRadians()
        let lat1 = self.latitude.toRadians()
        let lon1 = self.longitude.toRadians()
        let lat2 = asin(sin(lat1) * cos(distance) + cos(lat1) * sin(distance) * cos(bearing))
        let lon2 = lon1 + atan2(sin(bearing) * sin(distance) * cos(lat1), cos(distance) - sin(lat1) * sin(lat2))
        return CLLocationCoordinate2D(latitude: lat2.toDegrees(), longitude: lon2.toDegrees())
    }

    // Calculate the coordinate at a certain distance and bearing from this coordinate
    func coordinate(atDistance: CLLocationDistance, atBearing: Double, atAltitude: CLLocationDistance) -> CLLocationCoordinate2D {
        let distance = atDistance / 6371000.0
        let bearing = atBearing.toRadians()
        let lat1 = self.latitude.toRadians()
        let lon1 = self.longitude.toRadians()
        let lat2 = asin(sin(lat1) * cos(distance) + cos(lat1) * sin(distance) * cos(bearing))
        let lon2 = lon1 + atan2(sin(bearing) * sin(distance) * cos(lat1), cos(distance) - sin(lat1) * sin(lat2))
        return CLLocationCoordinate2D(latitude: lat2.toDegrees(), longitude: lon2.toDegrees())
    } */
    
}

// Calculate distance bet. two points
// Default unit is statute miles
/* export function distance (lat1, lon1, lat2, lon2, unit) {
	if ((lat1 === lat2) && (lon1 === lon2)) {
		return 0
	}
	else {
		const radlat1 = Math.PI * lat1 / 180
		const radlat2 = Math.PI * lat2 / 180
		const theta = lon1 - lon2
		const radtheta = Math.PI * theta / 180
		// eslint-disable-next-line no-mixed-operators
		let dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta)
		if (dist > 1) {
			dist = 1
		}
		dist = Math.acos(dist)
		dist = dist * 180 / Math.PI
		dist = dist * 60 * 1.1515
		if (unit === 'KILOMETERS') { dist = dist * 1.609344 }
		if (unit === 'NAUTICAL_MILES') { dist = dist * 0.8684 }
		return dist
	}
}
*/
