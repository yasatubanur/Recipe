//
//  HomeViewModel.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import Foundation

class HomeViewModel {
    
    private var listArray = ["asparagus","chicken","noodle","pasta","salad","sandwich","somon","shrimp","soup"]
    private var images = ["asparagus.jpg","chicken.jpg","noodle.jpg","pasta.jpg","salad.jpg","sandwich.jpg","somon.jpg","shrimp.jpg","soup.jpg"]
    
    init() {}
    
    func getRecipeName(index: Int) -> String {
        return listArray[index]
    }
    
    func getImage(index: Int) -> String {
        return images[index]
    }
    
    func getRecipeCount() -> Int {
        return listArray.count
    }
}
