//
//  FeedResult.swift
//  Suara
//
//  Created by Muhammad Noor on 18/07/21.
//

import Foundation
import CoreData

// MARK: - FeedElement
struct FeedResult: Codable {
	let data: FeedData
}

// MARK: - DataClass
struct FeedData: Codable {
	let category: [Category]
	let productPromo: [Product]
}

// MARK: - Category
struct Category: Codable, Equatable {
	
	public static func == (lhs: Category, rhs: Category) -> Bool {
		return lhs.id == rhs.id
	}
	
	let imageURL: String
	let id: Int
	let name: String
	
	enum CodingKeys: String, CodingKey {
		case imageURL = "imageUrl"
		case id, name
	}
}

// MARK: - Product
open class Product: Codable, Equatable {
	
	public static func == (lhs: Product, rhs: Product) -> Bool {
		return lhs.id == rhs.id
	}
	
	var id, imageURL: String
	var title, productPromoDescription, price: String
	var loved: Int
	
	enum CodingKeys: String, CodingKey {
		case id
		case imageURL = "imageUrl"
		case title
		case productPromoDescription = "description"
		case price, loved
	}
	
	func parseToCoredataModel(context : NSManagedObjectContext) -> Favorite? {
		let favorite = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context) as? Favorite
		favorite?.title = self.title
		favorite?.desc = self.productPromoDescription
		favorite?.price = self.price
		favorite?.imageUrl = self.imageURL
		favorite?.loved = Int16(self.loved )
		favorite?.id = self.id
		
		return favorite
	}
	
	init(id: String, price: String, title: String, desc: String, loved: Int, imageUrl: String) {
		self.id = id
		self.price = price
		self.title = title
		self.loved = loved
		self.imageURL = imageUrl
		self.productPromoDescription = desc
	}
}

typealias Feed = FeedResult
