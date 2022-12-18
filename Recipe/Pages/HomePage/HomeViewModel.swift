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
    func removeRecipe(index: IndexPath)
}

class HomeViewModel {
    
    var recipes: [Recipe] = []
    var viewController: HomeViewControllerProtocol?
    
    init() {}
    
    func getRecipeName(index: Int) -> String? {
        return recipes[index].name
    }
    
    func getImage(index: Int) -> Data? {
        let data = recipes[index].imageData
        return data
    }
    
    func getRecipeCount() -> Int {
        return recipes.count
    }
}


extension HomeViewModel: HomeViewModelProtocol {
    
    func readData() {
        do {
            let request = Recipe.fetchRequest() as NSFetchRequest<Recipe>
            
            let recipes = try AppDelegate.sharedAppDelegate.coreDataStack.managedContext.fetch(request)
            print(recipes)
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
