//
//  StepModel.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 27.11.2022.
//

import Foundation

class StepModel {
    
    var id: UUID = UUID()
    var stepNumber: Int
    var stepDescription: String?
    
    
    init(number: Int) {
        self.stepNumber = number
        self.stepDescription = nil
    }
}
