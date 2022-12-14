//
//  RecipeModel.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import Foundation
import UIKit

struct RecipeModel {
    
    var id: UUID = UUID()
    var recipeName: String?
    var ingridentsArray = [IngredientsModel]()
    var stepArray = [StepModel]()
    var selectedImage: UIImage?
}
