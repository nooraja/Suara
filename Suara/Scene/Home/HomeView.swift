//
//  HomeView.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import UIKit

class HomeView: UIView {
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.register(FeedCell.self, forCellWithReuseIdentifier: "feedId")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		return view
	}()
	
	lazy var categoryView: CategoryView = {
		let view = CategoryView()
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .white
		addSubview(collectionView)
		addSubview(categoryView)
		
		categoryView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, right: safeAreaLayoutGuide.rightAnchor, height: 100)
		collectionView.anchor(top: categoryView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
