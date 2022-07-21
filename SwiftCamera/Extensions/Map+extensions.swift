//
//  Map+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 7/5/22.
//

import Foundation
import SwiftUI
import MapKit

extension Map {
    func mapStyle(_ mapType: MKMapType, showScale: Bool = true, showTraffic: Bool = false) -> some View {
        let map = MKMapView.appearance()
        map.mapType = mapType
        map.showsScale = showScale
        map.showsTraffic = showTraffic
        return self
    }

    func addAnnotations(_ annotations: [MKAnnotation]) -> some View {
        MKMapView.appearance().addAnnotations(annotations)
        return self
    }
    
    func addOverlay(_ overlay: MKOverlay) -> some View {
        MKMapView.appearance().addOverlay(overlay)
        return self
    }
}
