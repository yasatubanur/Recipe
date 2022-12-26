//
//  RecipeNameTableViewCell.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 1.12.2022.
//

import UIKit

protocol RecipeNameTableViewCellDelegate: AnyObject {
    
    func nameChanged(text: String)
}

class RecipeNameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField!
    
    weak var delegate: RecipeNameTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
    }

    @objc func nameTextFieldDidChange() {
        delegate?.nameChanged(text: nameTextField.text ?? "")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
