//
//  Ingredient+CoreDataProperties.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 11.12.2022.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var amount: Double
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var typeString: String?
    @NSManaged public var recipe: Recipe?

}

extension Ingredient : Identifiable {

}
