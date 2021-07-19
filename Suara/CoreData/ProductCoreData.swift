//
//  ProductCoreData.swift
//  Suara
//
//  Created by Muhammad Noor on 19/07/21.
//

import CoreData
import Foundation

class ProductCoreData {
	let mainContext: NSManagedObjectContext
	let coreDataHelper: CoreDataHelper
	
	public init(mainContext: NSManagedObjectContext, coreDataHelper: CoreDataHelper) {
		self.mainContext = mainContext
		self.coreDataHelper = coreDataHelper
	}
}


extension ProductCoreData {
	@discardableResult
	func addProductToFavorite(product : Product) -> Favorite? {
		var favorite : Favorite?
		favorite = product.parseToCoredataModel(context: mainContext)
		
		coreDataHelper.saveContext(mainContext)
		return favorite
	}
	
	func getFavoriteProduct() -> [Favorite]? {
		let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
		
		do {
			return try mainContext.fetch(request)
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
		}
		return nil
	}
	
	func removeFromFavorite(id : String) {
		let favorites = getFavoriteProduct()
		
		for favorite in favorites! {
			if (favorite.id == id) {
				mainContext.delete(favorite)
				coreDataHelper.saveContext(mainContext)
			}
		}
	}
	
	func removeFromFavorite(product : Favorite) -> [Favorite]? {
		
		mainContext.delete(product)
		coreDataHelper.saveContext(mainContext)
		
		return getFavoriteProduct()
	}
	
	func checkIfAlreadyOnFavorite(id : Int) -> [Favorite] {
		let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
		let predicate = NSPredicate(format: "id = %@", id)
		request.predicate = predicate
		do {
			return try mainContext.fetch(request)
		} catch {
			return []
		}
	}
	
	func removeAllFromFavorite(){
		let request: NSFetchRequest<NSFetchRequestResult> = Favorite.fetchRequest()
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
		do {
			try mainContext.execute(deleteRequest)
		} catch {
			print("Error Delete All")
		}
	}
	
}

extension Favorite {
	
	func parseToProductDetailModel() -> Product? {
		let product = Product(
			id: self.id ?? "",
			price: self.price ?? "",
			title: self.title ?? "",
			desc: self.desc ?? "",
			loved: Int(self.loved),
			imageUrl: self.imageUrl ?? ""
		)
		
		return product
	}
}
