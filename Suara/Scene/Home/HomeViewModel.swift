//
//  HomeViewModel.swift
//  Suara
//
//  Created by Muhammad Noor on 18/07/21.
//

import Foundation
import Combine

class HomeViewModel {
	
	let networkModel: HomeNetworkModel?
	var dataSource: Feed?
	var changeHandler: ((HomeViewModelChange) -> Void)?
	lazy var coreDataHelper = CoreDataHelper()
	lazy var productCoreData = ProductCoreData(mainContext: coreDataHelper.mainContext, coreDataHelper: coreDataHelper)
	
	init(networkModel: HomeNetworkModel) {
		self.networkModel = networkModel
	}
	
	func getFeeds() {
		networkModel?.getHome(.feed, { [weak self] result in
			
			guard let self = self else { return }
			
			switch result {
			
			case .failure(let error):
				DispatchQueue.main.async { [unowned self] in
					self.emit(change: .didEncounterError(error))
				}
			case .success(let response):
				
				guard let validResponse = response.first else { return }
				self.dataSource = response.first
				
				self.emit(change:.didUpdateHome(values: self.dataSource!))
			}
		})
	}
	
	func emit(change: HomeViewModelChange) {
		changeHandler?(change)
	}
}

enum HomeViewModelChange {
	case didUpdateHome(values: FeedResult)
	case didEncounterError(ErrorMessage?)
}

