//
//  HomeViewModel.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import Foundation
import CoreData
import UIKit

protocol HomeViewModelProtocol {
    
    func readData()
    func getRecipeName(index: Int) -> String?
    func getImage(index: Int) -> Data?
    func getRecipeCount() -> Int
    func getRecipeModel(index: IndexPath) -> Recipe
    func removeRecipe(index: IndexPath)
    func filter(text: String)
}

class HomeViewModel {
    
    var recipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    var viewController: HomeViewControllerProtocol?
    
    init() {}
    
    func getRecipeName(index: Int) -> String? {
        return filteredRecipes[index].name
    }
    
    func getImage(index: Int) -> Data? {
        let data = filteredRecipes[index].imageData
        return data
    }
    
    func getRecipeCount() -> Int {
        return filteredRecipes.count
    }
    
    func getRecipeModel(index: IndexPath) -> Recipe {
        return filteredRecipes[index.row]
    }
    
    func filter(text: String) {
        if text == "" {
            filteredRecipes = recipes
        } else {
            let newFilteredRecipe = recipes.filter { recipe in
                let nameContains =  recipe.name?.lowercased().contains(text.lowercased()) ?? false
                let ingredientsContains = searchInIngredients(recipe: recipe, text: text)
                return nameContains || ingredientsContains
            }
            filteredRecipes = newFilteredRecipe
        }
        viewController?.reloadData()
    }
    
    func searchInIngredients(recipe: Recipe, text: String) -> Bool {
        let filteredIngredients = recipe.ingredients?.filter({ ingredient in
            if let ingredientModel = ingredient as? Ingredient {
                return ingredientModel.name?.lowercased().contains(text.lowercased()) ?? false
            } else { return false }
        })
        return filteredIngredients?.count ?? 0 > 0
    }
}


extension HomeViewModel: HomeViewModelProtocol {
    
    func readData() {
        do {
            let request = Recipe.fetchRequest() as NSFetchRequest<Recipe>
            
            let recipes = try AppDelegate.sharedAppDelegate.coreDataStack.managedContext.fetch(request)
            self.filteredRecipes = recipes
            self.recipes = recipes
            viewController?.reloadData()
        } catch {
            print(error)
        }
    }
    
    func removeRecipe(index: IndexPath) {
        let recipe = recipes[index.row]
        AppDelegate.sharedAppDelegate.coreDataStack.managedContext.delete(recipe)
        recipes.remove(at: index.row)
        
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }
}
