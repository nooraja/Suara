//
//  UILabel+Extension.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import UIKit

extension UILabel {
		convenience public init(text: String? = nil, font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
				self.init()
				self.text = text
				self.font = font
				self.textColor = textColor
				self.textAlignment = textAlignment
				self.numberOfLines = numberOfLines
		}
}

