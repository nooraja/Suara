//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Muhammad Noor on 19/07/21.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var price: String?
    @NSManaged public var loved: Int16
    @NSManaged public var id: String?

}
