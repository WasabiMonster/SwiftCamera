//
//  TextField+modifiers.swift
//  Backflip
//
//  Created by Patrick Wilson on 4/28/22.
//

import SwiftUI
import UIKit

@available(iOS 13.0, *)
extension NoKeyboardTextField {

	/// Modifies the text field’s **font** from a `UIFont` object. 🔠🔡
	/// - Parameter font: The desired font 🅰️🆗
	/// - Returns: An updated text field using the desired font 💬
	/// - Warning: ⚠️ Accepts a `UIFont` object rather than SwiftUI `Font` ⚠️
	/// - SeeAlso: [`UIFont`](https://developer.apple.com/documentation/uikit/uifont)
	public func fontFromUIFont(_ font: UIFont?) -> NoKeyboardTextField {
		var view = self
		view.font = font
		return view
	}

	/// Modifies the **text color** 🎨 of the text field.
	/// - Parameter color: The desired text color 🌈
	/// - Returns: An updated text field using the desired text color 🚦
	@available(iOS 13, *)
	public func foregroundColor(_ color: Color?) -> NoKeyboardTextField {
		var view = self
		if let color = color {
			view.foregroundColor = UIColor.from(color: color)
		}
		return view
	}

	/// Modifies the **cursor color** 🌈 of the text field 🖱 💬
	/// - Parameter accentColor: The cursor color 🎨
	/// - Returns: A phone number text field with updated cursor color 🚥🖍
	@available(iOS 13, *)
	public func accentColor(_ accentColor: Color?) -> NoKeyboardTextField {
		var view = self
		if let accentColor = accentColor {
			view.accentColor = UIColor.from(color: accentColor)
		}
		return view
	}

	/// Modifies the **text alignment** of a text field. ⬅️ ↔️ ➡️
	/// - Parameter alignment: The desired text alignment 👈👉
	/// - Returns: An updated text field using the desired text alignment ↩️↪️
	public func multilineTextAlignment(_ alignment: TextAlignment) -> NoKeyboardTextField {
		var view = self
		switch alignment {
		case .leading:
			view.textAlignment = layoutDirection ~= .leftToRight ? .left : .right
		case .trailing:
			view.textAlignment = layoutDirection ~= .leftToRight ? .right : .left
		case .center:
			view.textAlignment = .center
		}
		return view
	}

	/// Modifies the function called when text editing **begins**. ▶️
	/// - Parameter action: The function called when text editing begins 🏁. Does nothing if `nil`.
	/// - Returns: An updated text field using the desired function called when text editing begins ➡️
	public func onEditingBegan(perform action: (() -> Void)? = nil) -> NoKeyboardTextField {
		var view = self
		if let action = action {
			view.didBeginEditing = action
		}
		return view

	}

	/// Modifies the function called when the user makes any **changes** to the text in the text field.
	public func onEdit(perform action: (() -> Void)? = nil) -> NoKeyboardTextField {
		var view = self
		if let action = action {
			view.didChange = action
		}
		return view

	}

	/// Modifies the function called when text editing **ends**. 🔚
	public func onEditingEnded(perform action: (() -> Void)? = nil) -> NoKeyboardTextField {
		var view = self
		if let action = action {
			view.didEndEditing = action
		}
		return view
	}

	public func style(
		height: CGFloat = 58,
		backgroundColor: Color? = nil,
		accentColor: Color = Color(red: 0.30, green: 0.76, blue: 0.85),
		font inputFont: UIFont? = nil,
		paddingLeading: CGFloat = 25,
		cornerRadius: CGFloat = 6,
		hasShadow: Bool = true,
		image: Image? = nil
	) -> some View {
		var darkMode: Bool = true // { colorScheme == .dark }

		let cursorColor: Color = accentColor
		let height: CGFloat = height
		let leadingPadding: CGFloat = paddingLeading

		var backgroundGray: Double { darkMode ? 0.25 : 0.95 }

		var finalBGColor: Color {
			if let backgroundColor = backgroundColor {
				return backgroundColor
			}
			return .init(white: backgroundGray)
		}

		var shadowOpacity: Double { (designEditing && hasShadow) ? 0.5 : 0 }
		var shadowGray: Double { darkMode ? 0.8 : 0.5 }
		var shadowColor: Color { Color(white: shadowGray).opacity(shadowOpacity) }

		var borderColor: Color {
			designEditing && darkMode ? .init(white: 0.6) : .clear
		}

		var font: UIFont {
			if let inputFont = inputFont {
				return inputFont
			} else {
				let fontSize: CGFloat = 20
				let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .regular)
				if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
					return  UIFont(descriptor: descriptor, size: fontSize)
				} else {
					return systemFont
				}
			}
		}

		return ZStack {
			HStack {
				if let image = image {
					image
				}
				self
					.accentColor(cursorColor)
					.fontFromUIFont(font)
			}
			.padding(.horizontal, leadingPadding)
		}
		.frame(height: height)
		.background(finalBGColor)
		.cornerRadius(cornerRadius)
		.overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(borderColor))
		.padding(.horizontal, leadingPadding)
		.shadow(color: shadowColor, radius: 5, x: 0, y: 4)
	}

	/// Since Apple has not given us a way yet to parse a `Font` 🔠🔡  object, this function must be deprecated 😔. Please use `.fontFromUIFont(_:)` instead 🙂.
	/// - Parameter font:
	/// - Returns:
	@available(*, deprecated, renamed: "fontFromUIFont", message: "At this time, Apple will not let us parse a `Font` object❗️ Please use `.fontFromUIFont(_:)` instead.")
	public func font(_ font: Font?) -> some View { return EmptyView() }
}
