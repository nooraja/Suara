//
//  UIImage+Extension.swift
//  Suara
//
//  Created by Muhammad Noor on 18/07/21.
//

import UIKit
import SDWebImage

extension UIImageView {

	func loadImage(ath urlPath: String)  {
		
		guard let url = URL(string: urlPath) else {
			return
		}
		
		self.sd_imageIndicator = SDWebImageActivityIndicator.gray
		self.sd_setImage(with: url, placeholderImage: UIImage(), options: .highPriority, completed: nil)
	}
	
}
