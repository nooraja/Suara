//
//  CoreDataHelper.swift
//  Suara
//
//  Created by Muhammad Noor on 19/07/21.
//

import Foundation
import CoreData

open class CoreDataHelper {
		
		public static let modelName = "suara"

		public static let model: NSManagedObjectModel = {
			let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
			return NSManagedObjectModel(contentsOf: modelURL)!
		}()

		public init() {
		}

		public lazy var mainContext: NSManagedObjectContext = {
			return storeContainer.viewContext
		}()

		public lazy var storeContainer: NSPersistentContainer = {
			let container = NSPersistentContainer(name: CoreDataHelper.modelName, managedObjectModel: CoreDataHelper.model)
			container.loadPersistentStores { _, error in
				if let error = error as NSError? {
					fatalError("Unresolved error \(error), \(error.userInfo)")
				}
			}
			return container
		}()

		public func newDerivedContext() -> NSManagedObjectContext {
			let context = storeContainer.newBackgroundContext()
			return context
		}

		public func saveContext() {
			saveContext(mainContext)
		}

		public func saveContext(_ context: NSManagedObjectContext) {
			if context != mainContext {
				saveDerivedContext(context)
				return
			}

			context.perform {
				do {
					try context.save()
				} catch let error as NSError {
					fatalError("Unresolved error \(error), \(error.userInfo)")
				}
			}
		}

		public func saveDerivedContext(_ context: NSManagedObjectContext) {
			context.perform {
				do {
					try context.save()
				} catch let error as NSError {
					fatalError("Unresolved error \(error), \(error.userInfo)")
				}

				self.saveContext(self.mainContext)
			}
		}
}

