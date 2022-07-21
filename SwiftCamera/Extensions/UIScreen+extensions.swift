//
//  UIScreen+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 12/15/21.
//

import UIKit

public extension UIScreen {

    static var screenSize: CGSize {
        #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.size
        #elseif os(watchOS)
        return WKInterfaceDevice.current().screenBounds.size
        #else
        return NSScreen.main?.frame.size ?? .zero
        #endif
    }

    static var screenHeight: CGFloat {
        screenSize.height
    }

    static var screenWidth: CGFloat {
        screenSize.width
    }    
}
