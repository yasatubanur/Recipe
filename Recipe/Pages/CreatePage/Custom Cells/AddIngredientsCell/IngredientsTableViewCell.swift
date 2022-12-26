//
//  IngredientsTableViewCell.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 8.10.2022.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dropdownButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var ingredientsModel: IngredientsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        let menuClosure = {(action: UIAction) in
            
            self.update(number: action.title)
        }
        amountTextField.addTarget(self, action: #selector(amountTextFieldDidChange), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        //TODO :
        dropdownButton.menu = UIMenu(children: [
            UIAction(title: "dessertspoon", handler: menuClosure),
            UIAction(title: "smidgen", handler: menuClosure),
            UIAction(title: "pinch", handler: menuClosure),
            UIAction(title: "saltspoon", state: .on, handler:
                        menuClosure),
            UIAction(title: "coffeespoon", handler: menuClosure),
            UIAction(title: "dram", handler: menuClosure),
            UIAction(title: "teaspoon", state: .on, handler:
                        menuClosure),
            UIAction(title: "tablespoon", handler: menuClosure),
            UIAction(title: "wineglass", state: .on, handler:
                        menuClosure),
            UIAction(title: "teacup", handler: menuClosure),
            UIAction(title: "cup", handler: menuClosure),
            UIAction(title: "pint", state: .on, handler:
                        menuClosure),
            UIAction(title: "quart", handler: menuClosure),
            UIAction(title: "gallon", handler: menuClosure),
            UIAction(title: "can", handler: menuClosure),
            UIAction(title: "ml", handler: menuClosure),
            UIAction(title: "g", handler: menuClosure),
            UIAction(title: "pound", handler: menuClosure),
            UIAction(title: "large", handler: menuClosure),
            UIAction(title: "amount ", state: .on, handler:
                        menuClosure),
        ])
        dropdownButton.showsMenuAsPrimaryAction = true
        dropdownButton.changesSelectionAsPrimaryAction = true
    }
    
    func update(number:String) {
        print(number)
        ingredientsModel?.amountType = AmountType(rawValue: number) ?? .smidgen
        if number == "option 1" {
            print("option 1 selected")
        }
    }
    
    @objc func amountTextFieldDidChange() {
        ingredientsModel?.amount = Int(amountTextField.text!) ?? 0
    }
    
    @objc func nameTextFieldDidChange() {
        ingredientsModel?.name = nameTextField.text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
