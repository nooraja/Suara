//
//  FavoriteViewModel.swift
//  Suara
//
//  Created by Muhammad Noor on 19/07/21.
//

import Foundation

class FavoriteViewModel {
	
	lazy var coreDataHelper = CoreDataHelper()
	lazy var favoriteCoreData = ProductCoreData(mainContext: coreDataHelper.mainContext, coreDataHelper: coreDataHelper)
	
	var dataSources: [Favorite] {
		return self.favoriteCoreData.getFavoriteProduct() ?? []
	}
}
