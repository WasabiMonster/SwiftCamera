//
//  Image+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 9/17/21.
//

import SwiftUI

extension Image {

    func asThumbnail(withMaxWidth maxHeight: CGFloat = 100) -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: maxHeight)
    }
    
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }

}
