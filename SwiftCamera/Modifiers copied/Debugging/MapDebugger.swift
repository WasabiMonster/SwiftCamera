//
//  MapDebugger.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/11/22.
//

import Foundation
import SwiftUI
import MapKit

extension View {
    func mapDebugger(map: MKMapView) -> some View {
        modifier(MapDebugger(map: map))
    }
}

private struct MapDebugger: ViewModifier {
    static let color: Color = .blue
    
    let map: MKMapView
    
    func body(content: Content) -> some View {
        content
            .overlay(GeometryReader(content: overlay(for:)))
    }

    func overlay(for geometry: GeometryProxy) -> some View {
        ZStack(
            alignment: Alignment(
                horizontal: .trailing,
                vertical: .top
            )
        ) {
            Rectangle()
                .strokeBorder(
                    style: StrokeStyle(lineWidth: 1, dash: [5])
                )
                .foregroundColor(MapDebugger.color)
            Text("\(Int(geometry.size.width))x\(Int(geometry.size.height))")
                .font(.caption2)
                .foregroundColor(MapDebugger.color)
                .padding(2)

            Text("\(map.centerCoordinate.latitude) - \(map.centerCoordinate.longitude)")
                .font(.caption2)
                .foregroundColor(MapDebugger.color)
                .padding(2)
        }
    }
}
