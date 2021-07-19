//
//  CategoryCell.swift
//  Suara
//
//  Created by Muhammad Noor on 18/07/21.
//

import UIKit

class CategoryCell: UICollectionViewCell {
	
	lazy var imageCategory: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFit
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel(font: .systemFont(ofSize: 14), textColor: .black, textAlignment: .center, numberOfLines: 0)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(titleLabel)
		addSubview(imageCategory)
		
		titleLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 20)
		imageCategory.anchor(top: topAnchor, left: leftAnchor, bottom: titleLabel.topAnchor, right: rightAnchor)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func configure(with value: Category) {
		titleLabel.text = value.name
		imageCategory.loadImage(ath: value.imageURL)
	}
}
