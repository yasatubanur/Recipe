//
//  UITableViewExtensions.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 4.09.2022.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerNib(withIdentifier identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier:  identifier)
    }
    
    func dequeue<T: UITableViewCell>(withIdentifier identifier: String = String(describing: T.self), at indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier \(identifier) from tableView \(self)")
        }
        return cell
    }
}
