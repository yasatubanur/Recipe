//
//  Step+CoreDataProperties.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 11.12.2022.
//
//

import Foundation
import CoreData


extension Step {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Step> {
        return NSFetchRequest<Step>(entityName: "Step")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var number: Int16
    @NSManaged public var stepDescription: String?
    @NSManaged public var recipe: Recipe?

}

extension Step : Identifiable {

}
