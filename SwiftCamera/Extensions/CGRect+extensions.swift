//
//  CGRect+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/2/22.
//

import Foundation
import CoreGraphics

extension CGRect {

    public var description: String {
        return "\(self.minX),\(self.minY)_|\(self.width),\(self.height)"
    }

}
