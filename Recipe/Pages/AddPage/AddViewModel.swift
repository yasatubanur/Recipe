//
//  AddViewControllerViewModel.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 14.12.2022.
//

import Foundation
import UIKit

protocol AddViewModelProtocol {
    func saveData()
    func getIngredientsCount() -> Int
    func getStepArrayCount() -> Int
    func getIngredientModel(index: Int) -> IngredientsModel
    func getStepModel(index: Int) -> StepModel
    func getImage() -> UIImage?
    func addIngredient(model: IngredientsModel)
    func addStep(model: StepModel)
    func setImage(image: UIImage)
    func setRecipeName(name: String)
}

class AddViewModel {
    
    var recipeModel: RecipeModel = RecipeModel()
    
    init() {
        
    }
}


extension AddViewModel: AddViewModelProtocol {
    
    func saveData() {
        let recipe = Recipe(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContext)
        recipe.name = recipeModel.recipeName
        recipe.imageData = recipeModel.selectedImage?.pngData()
        recipe.id = UUID()
        
        recipeModel.ingridentsArray.forEach { addingIng in
            let ing = Ingredient(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContext)
            ing.id = UUID()
            ing.amount = Double(addingIng.amount)
            ing.typeString = addingIng.amountType.rawValue
            ing.name = addingIng.name
            recipe.addToIngredients(ing)
        }
        
        recipeModel.stepArray.forEach { addingStep in
            let step = Step(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContext)
            step.id = UUID()
            step.number = Int16(addingStep.stepNumber)
            step.stepDescription = addingStep.stepDescription
            recipe.addToSteps(step)
        }
        
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        
    }
    
    func getIngredientsCount() -> Int {
        return recipeModel.ingridentsArray.count
    }
    
    func getStepArrayCount() -> Int {
        return recipeModel.stepArray.count
    }
    
    func getIngredientModel(index: Int) -> IngredientsModel {
        return recipeModel.ingridentsArray[index]
    }
    
    func getStepModel(index: Int) -> StepModel {
        return recipeModel.stepArray[index]
    }
    
    func getImage() -> UIImage? {
        return recipeModel.selectedImage ?? UIImage(systemName: "camera")
    }
    
    func addIngredient(model: IngredientsModel) {
        recipeModel.ingridentsArray.append(model)
    }
    
    func addStep(model: StepModel) {
        recipeModel.stepArray.append(model)
    }
    
    func setImage(image: UIImage) {
        recipeModel.selectedImage = image
    }
    
    func setRecipeName(name: String) {
        recipeModel.recipeName = name
    }
}
