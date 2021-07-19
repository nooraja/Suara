//
//  SearchController.swift
//  Suara
//
//  Created by Muhammad Noor on 19/07/21.
//

import UIKit

class SearchController: UIViewController {
	
	var viewModel: SearchViewModel?
	
	private lazy var tableView: UITableView = {
		let view = UITableView()
		view.tableFooterView = UIView()
		view.estimatedRowHeight = 120
		view.backgroundColor = .white
		view.register(SearchCell.self, forCellReuseIdentifier: "searchId")
		view.separatorStyle = .singleLine
		view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		view.dataSource = self
		view.delegate = self
		
		return view
	}()
	
	lazy var searchBar = UISearchBar()
	
	
	required init(viewModel: SearchViewModel) {
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
		searchBar.searchBarStyle = .prominent
		searchBar.placeholder = "Search..."
		searchBar.sizeToFit()
		searchBar.isTranslucent = false
		searchBar.backgroundImage = UIImage()
		searchBar.delegate = self
		navigationItem.titleView = searchBar
		
		view.backgroundColor = .white
		view.addSubview(tableView)
		tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
		tableView.reloadData()
	}
	
}

extension SearchController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
	
	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		return true
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
	}
	
	func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		return true
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		viewModel?.text = searchBar.text ?? ""
		tableView.reloadData()
		searchBar.endEditing(true)
		
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.dataSources?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "searchId", for: indexPath) as! SearchCell
		
		guard let data = viewModel?.dataSources?[indexPath.row] else {
			return cell
		}
		
		cell.configure(data)
		
		return cell
	}
}
