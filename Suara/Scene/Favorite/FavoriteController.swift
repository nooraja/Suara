//
//  FavoriteController.swift
//  Suara
//
//  Created by Muhammad Noor on 19/07/21.
//

import UIKit

class FavoriteController: UIViewController {

	var viewModel: FavoriteViewModel?
	
	private lazy var tableView: UITableView = {
		let view = UITableView()
		view.tableFooterView = UIView()
		view.estimatedRowHeight = 120
		view.backgroundColor = .white
		view.register(FavoriteCell.self, forCellReuseIdentifier: "favoriteId")
		view.separatorStyle = .singleLine
		view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		view.dataSource = self
		view.delegate = self
		
		return view
	}()
	
	lazy var searchBar = UISearchBar()
	
	
	required init(viewModel: FavoriteViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		searchBar.becomeFirstResponder()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		configureView()
	}
	
	func configureView() {
		
		view.backgroundColor = .white
		view.addSubview(tableView)
		tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
		tableView.reloadData()
	}
	
}

extension FavoriteController: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.dataSources.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteId", for: indexPath) as! FavoriteCell
		
		guard let data = viewModel?.dataSources[indexPath.row] else {
			return cell
		}
		
		cell.configure(data)
		
		return cell
	}
}

