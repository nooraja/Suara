//
//  HomeController.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import UIKit
import Combine

enum SectionHome {
	case category
	case feed
}

class HomeController: UIViewController {
	
	let mainView: HomeView
	let viewModel: HomeViewModel
	var subscription: AnyCancellable?
	
	lazy var searchBar = UISearchBar()
	
	required init(mainView: HomeView, viewModel: HomeViewModel) {
		self.mainView = mainView
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		searchBar.searchBarStyle = .prominent
		searchBar.placeholder = "Search..."
		searchBar.sizeToFit()
		searchBar.isTranslucent = false
		searchBar.backgroundImage = UIImage()
		searchBar.delegate = self
		
		let likeIcon = UIImage(systemName: "heart.fill")
		self.navigationItem.titleView = searchBar
		self.navigationController?.navigationBar.backIndicatorImage = likeIcon
		self.navigationController?.navigationBar.tintColor = .black
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .done)
	}
	
	override func loadView() {
		super.loadView()
		
		view = mainView
		mainView.collectionView.delegate = self
		mainView.collectionView.dataSource = self
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.getFeeds()
		
		viewModel.changeHandler = { [weak self] result in
			
			guard let self = self else { return }
			
			switch result {
			case .didUpdateHome(let result):
				self.mainView.categoryView.dataSource = result.data.category
				
				DispatchQueue.main.async {
					self.mainView.categoryView.collectionView.reloadData()
					self.mainView.collectionView.reloadData()
				}
			case .didEncounterError(let error):
				print(error)
			}
		}
	}
	
	@objc func whenTappedLike() {
		
	}
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.dataSource?.data.productPromo.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedId", for: indexPath) as! FeedCell
		
		guard let validProduct = viewModel.dataSource?.data.productPromo else {
			return cell
		}
		
		cell.configure(product: validProduct[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let data = viewModel.dataSource?.data.productPromo[indexPath.item] {
			let controller = ProductDetailController()
			controller.product = data
			controller.hidesBottomBarWhenPushed = true
			navigationController?.pushViewController(controller, animated: true)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = UIScreen.main.bounds.width
		return CGSize(width: width, height: width)
	}
	
	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		let vc = SearchController(viewModel: SearchViewModel())
		vc.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(vc, animated: true)
		
		return false
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
	}
	
	func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		
		return true
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
	}
}
