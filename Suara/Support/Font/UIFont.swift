//
//  UIFont.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import UIKit

extension UIFont {
	
	public enum RobotoType: String {
		case medium = "-Medium"
		case regular = "-Regular"
		case light = "-Light"
		case extraBold = "-Black"
		case bold = "-Bold"
	}
	
	static func Roboto(_ type: RobotoType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
		return UIFont(name: "Roboto\(type.rawValue)", size: size)!
	}

	
	var isBold: Bool {
		return fontDescriptor.symbolicTraits.contains(.traitBold)
	}
	
	var isItalic: Bool {
		return fontDescriptor.symbolicTraits.contains(.traitItalic)
	}
	
}
