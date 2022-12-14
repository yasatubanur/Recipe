//
//  HomeViewModel.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import Foundation
import CoreData

class HomeViewModel {
    
    private var recipeModel = RecipeModel()
    
    private var images = ["asparagus.jpg","chicken.jpg","noodle.jpg","pasta.jpg","salad.jpg","sandwich.jpg","somon.jpg","shrimp.jpg","soup.jpg","asparagus.jpg","chicken.jpg","noodle.jpg","pasta.jpg","salad.jpg","sandwich.jpg","somon.jpg","shrimp.jpg","soup.jpg"]
    
    init() {
        images += images
    }
    
    func getRecipeName(index: Int) -> String? {
        return "hey"
    }
    
    func getImage(index: Int) -> String {
        return images[index]
    }
    
    func getRecipeCount() -> Int {
        return 7
    }
}
