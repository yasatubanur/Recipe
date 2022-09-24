//
//  UIViewControllerExtensions.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 6.09.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
           let vc =  UINib(nibName: String(describing: T.self), bundle: nil).instantiate(withOwner: self, options: nil).first as? T
            return vc ?? T()
        }

        return instantiateFromNib()
    }
}
