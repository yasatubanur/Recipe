//
//  Recipe+CoreDataProperties.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 11.12.2022.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imageData: Data?
    @NSManaged public var ingredients: NSOrderedSet?
    @NSManaged public var steps: NSOrderedSet?

}

// MARK: Generated accessors for ingredients
extension Recipe {

    @objc(insertObject:inIngredientsAtIndex:)
    @NSManaged public func insertIntoIngredients(_ value: Ingredient, at idx: Int)

    @objc(removeObjectFromIngredientsAtIndex:)
    @NSManaged public func removeFromIngredients(at idx: Int)

    @objc(insertIngredients:atIndexes:)
    @NSManaged public func insertIntoIngredients(_ values: [Ingredient], at indexes: NSIndexSet)

    @objc(removeIngredientsAtIndexes:)
    @NSManaged public func removeFromIngredients(at indexes: NSIndexSet)

    @objc(replaceObjectInIngredientsAtIndex:withObject:)
    @NSManaged public func replaceIngredients(at idx: Int, with value: Ingredient)

    @objc(replaceIngredientsAtIndexes:withIngredients:)
    @NSManaged public func replaceIngredients(at indexes: NSIndexSet, with values: [Ingredient])

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSOrderedSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSOrderedSet)

}

// MARK: Generated accessors for steps
extension Recipe {

    @objc(insertObject:inStepsAtIndex:)
    @NSManaged public func insertIntoSteps(_ value: Step, at idx: Int)

    @objc(removeObjectFromStepsAtIndex:)
    @NSManaged public func removeFromSteps(at idx: Int)

    @objc(insertSteps:atIndexes:)
    @NSManaged public func insertIntoSteps(_ values: [Step], at indexes: NSIndexSet)

    @objc(removeStepsAtIndexes:)
    @NSManaged public func removeFromSteps(at indexes: NSIndexSet)

    @objc(replaceObjectInStepsAtIndex:withObject:)
    @NSManaged public func replaceSteps(at idx: Int, with value: Step)

    @objc(replaceStepsAtIndexes:withSteps:)
    @NSManaged public func replaceSteps(at indexes: NSIndexSet, with values: [Step])

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: Step)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: Step)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSOrderedSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSOrderedSet)

}

extension Recipe : Identifiable {

}
