//
//  IngredientsModel.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 26.11.2022.
//

import Foundation

class IngredientsModel {
    
    var id: UUID = UUID()
    var amount: Int
    var amountType: AmountType
    var name: String?
    
    init() {
        self.amount = 0
        self.amountType = .dessertspoon
        self.name = nil
    }
}


enum AmountType: String {
    case dessertspoon
    case smidgen
    case saltspoon
    case coffeespoon
    case dram
    case teaspoon
    case tablespoon
    case wineglass
    case teacup
    case cup
    case pint
    case quart
    case gallon
    case gill
}
