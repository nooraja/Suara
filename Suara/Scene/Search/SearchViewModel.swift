//
//  SearchViewModel.swift
//  Suara
//
//  Created by Muhammad Noor on 19/07/21.
//

import Foundation

class SearchViewModel {
	
	var text = ""
	lazy var coreDataHelper = CoreDataHelper()
	lazy var favoriteCoreData = ProductCoreData(mainContext: coreDataHelper.mainContext, coreDataHelper: coreDataHelper)
	
	var dataSources: [Product]? {
		let product = self.favoriteCoreData.getFavoriteProduct()?.compactMap { $0 }.filter{
			return $0.title?.lowercased().contains(self.text.lowercased()) ?? false
		}
		
		var validProduct: [Product]?
		product?.forEach{
			validProduct?.append(Product(id: $0.id ?? "", price: $0.price ?? "", title: $0.title ?? "", desc: $0.desc ?? "", loved: Int($0.loved), imageUrl: $0.imageUrl ?? ""))
		}
		
		return validProduct
	}
}
