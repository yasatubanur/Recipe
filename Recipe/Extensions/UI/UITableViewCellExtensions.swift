//
//  UITableViewCellExtensions.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 8.10.2022.
//

import UIKit

protocol CellConfigurator {
    
    associatedtype Item
    associatedtype Delegate
    
    var viewModel: Item? { get set}
    var delegate: Delegate? { get set }
    var indexPath: IndexPath? { get set }
    mutating func configure(viewModel: Item?, delegate: Delegate?, indexPath: IndexPath?)
    func fillFields(viewModel: Item)
}

extension CellConfigurator {
    
    mutating func configure(viewModel: Item? = nil, delegate: Delegate? = nil, indexPath: IndexPath? = nil) {
        
        self.indexPath = indexPath
        self.delegate = delegate
        
        if let viewModel = viewModel {
            self.viewModel = viewModel
            fillFields(viewModel: viewModel)
        }
    }
}

extension UITableViewCell {
    
    static func dequeueCell(fromTableView tableView: UITableView, atIndexPath indexPath: IndexPath) -> Self {
        guard let cell: Self = tableView.dequeue(withIdentifier: self.className, at: indexPath) as? Self else {
            #if DEBUG
            fatalError("*** Failed to dequeue Cell ***")
            #else
            return Self()
            #endif
        }
        return cell
    }
}
