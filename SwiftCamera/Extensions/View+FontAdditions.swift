//
//  View+FontAdditions.swift
//  Backflip
//
//  Created by Patrick Wilson on 10/19/21.
//

import Foundation
import SwiftUI

public protocol FontProtocol {
    var name: String { get }
}

public enum Poppins: String, FontProtocol {
    case regular, bold, medium, light, thin
    
    public var name: String {
        switch self {
        case .regular:
            return "Poppins-Regular"
        case .bold:
            return "Poppins-Bold"
        case .medium:
            return "Poppins-Medium"
        case .light:
            return "Poppins-Light"
        case .thin:
            return "Poppins-Thin"
        }
    }
}

public extension ContentSizeCategory {
    
    var size: CGFloat {
        switch self {
        case .extraSmall:
            return 12
        case .small:
            return 14
        case .medium:
            return 16
        case .large:
            return 20
        case .extraLarge:
            return 26
        case .extraExtraLarge:
            return 40
		case .extraExtraExtraLarge:
			return 58
        default:
            return 16
        }
    }
}

public extension View {
    
    func customFont(_ font: Poppins, category: ContentSizeCategory) -> some View {
        return self.customFont(font.rawValue, category: category)
    }
    
    func customFont(_ name: String, category: ContentSizeCategory) -> some View {
        return self.font(.custom(name, size: category.size))
    }

    func customFont(_ name: String, customSize: CGFloat) -> some View {
        return self.font(.custom(name, size: customSize))
    }
    
}
