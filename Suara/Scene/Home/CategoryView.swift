//
//  CategoryView.swift
//  Suara
//
//  Created by Muhammad Noor on 18/07/21.
//

import UIKit

class CategoryView: UIView {
	
	var dataSource: [Category]?
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryId")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.delegate = self
		view.dataSource = self
		return view
	}()
		
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(collectionView)
		collectionView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CategoryView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataSource?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryId", for: indexPath) as! CategoryCell
		
		guard let validItem = dataSource?[indexPath.row] else { return cell }
		cell.configure(with: validItem)
		return cell
		
	}
		
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (UIScreen.main.bounds.width / 4) - 10
		return CGSize(width: width, height: 70)
	}
	
}
