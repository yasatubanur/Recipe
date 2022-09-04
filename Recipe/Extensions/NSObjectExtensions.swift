//
//  NSObjectExtensions.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 4.09.2022.
//

import Foundation

extension NSObject {
    
    class var className: String {
        return String(describing: self)
    }
}
