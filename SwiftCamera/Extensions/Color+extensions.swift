//
//  Color+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/2/21.
//

import Foundation
import SwiftUI

// MARK: - Backflip Colors
extension Color {
    
    static let primaryGreen: Color = Color("primary-green", bundle: .main)
    static let primaryDarkGreen: Color = Color("primary-dark-green", bundle: .main)
    
    static let secondaryRed: Color = Color("secondary-red", bundle: .main)
	static let secondaryPink: Color = Color("secondary-pink", bundle: .main)
	static let secondaryOrange: Color = Color("secondary-orange", bundle: .main)
	static let secondaryViolet: Color = Color("secondary-violet", bundle: .main)
	static let secondaryBlue: Color = Color("secondary-blue", bundle: .main)
	static let secondaryGreen: Color = Color("secondary-green", bundle: .main)

	static let darkRed: Color = Color("dark-red", bundle: .main)
    static let tertiaryTeal: Color = Color("tertiary-teal", bundle: .main)
    static let tertiaryTeal50: Color = Color("tertiary-teal-50", bundle: .main)
    static let lightTeal: Color = Color("light-teal", bundle: .main)
    static let prominentGreen: Color = Color("prominent-green", bundle: .main)
    static let slightGray: Color = Color("slight-gray", bundle: .main)
    
    static let neutralDark: Color = Color("neutral-dark", bundle: .main)
    static let neutralGray: Color = Color("neutral-gray", bundle: .main)
    static let neutralGray50: Color = Color("neutral-gray-50", bundle: .main)
    static let neutralLightShades: Color = Color("neutral-light-shades", bundle: .main)
    static let neutralFieldBackground: Color = Color("neutral-field-background", bundle: .main)
    
}

/*

 ///////////////////
 // Backflip colors
 //////////////////

 $backflip-blue: #354052;
 $backflip-green: #005A61;

 $backflip-primary-green: #005A61;
 $backflip-primary-dark-green: #354052;
 $backflip-secondary-red: #FC245F;
 $backflip-dark-red: #B21943;
 $backflip-tertiary-teal: #00ADC2;
 $backflip-light-teal: #F1FFFA;
 $backflip-prominent-green: #A2FFDA;
 $backflip-slight-gray: #F7F8FA;
 $backflip-hover-gray: #EEEEEE;

 $backflip-neutral-dark: #273142;
 $backflip-neutral-gray: #516173;
 $backflip-neutral-gray50: #A8AAB7;
 $backflip-neutral-light-shades: #C5D0DE;
 $backflip-neutral-lighter-shades: #E8F3FA;
 $backflip-neutral-field-background: #F1F4F8;
 $backflip-neutral-background: #F3F3F3;

 $backflip-secondary-pink: #FF5A80;
 $backflip-secondary-orange: #FF9A15;
 $backflip-secondary-violet: #8D57F5;
 $backflip-secondary-blue: #1569FF;
 $backflip-secondary-green: #06B491;
 
 */

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

extension Color {
    public init(hex: Int) {
        self.init(UIColor(hex: hex))
   }
}

// MARK: - Backflip Profile Color Rendering
extension Color {
	static func fromName(initials: String) -> Color {
		guard let firstLetter = initials.first?.uppercased() else { return Color.neutralDark }

		let options: [Color] = [
			Color.secondaryRed,
			Color.secondaryBlue,
			Color.secondaryPink,
			Color.secondaryGreen,
			Color.secondaryOrange,
			Color.secondaryViolet
		]

		let alphaBet: [String] = [
			"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
		]

		guard let indx = alphaBet.firstIndex(where: { $0 == firstLetter }) else { return Color.primaryGreen }
		return options[indx % options.count]
	}
}
