//
//  FilterTableViewCell.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 21.12.2022.
//

import UIKit

protocol FilterTableViewCellDelegate: AnyObject {
    
    func search(text: String)
}

class FilterTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var searchField: UITextField!
    
    weak var delegate: FilterTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchField.delegate = self
        
        searchField.addTarget(self, action: #selector(searchTextFieldDidChange), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func searchTextFieldDidChange() {
        delegate?.search(text: searchField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.search(text: searchField.text ?? "")
        return true
    }
}
