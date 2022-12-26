//
//  DetailViewController.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 18.12.2022.
//

import UIKit

fileprivate enum Sections: Int {
    case image = 0
    case name = 1
    case ingredients = 2
    case steps = 3
}

fileprivate enum Constants {
    static let defaultListImage = "listRecipeImage"
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    var recipeModel: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        detailTableView.registerNib(withIdentifier: AddImageTableViewCell.className)
        detailTableView.registerNib(withIdentifier: DetailRecipeNameTableViewCell.className)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.estimatedRowHeight = 100
    }
    
    @objc func editAction() {
            let createViewController = CreateViewController.loadFromNib()
            createViewController.pageType = .create
            navigationController?.pushViewController(createViewController, animated: true)
    }
    
    func getIngredientsText() -> String {
        var ingredientsString: String = ""
        recipeModel?.ingredients?.forEach({ ing in
            if let ingModel = ing as? Ingredient {
                let rowString = "\(ingModel.amount) \(String(describing: ingModel.typeString!)) \(String(describing: ingModel.name!)) \n"
                ingredientsString.append(rowString)
            } else {}
        })
        return ingredientsString
    }
    
    func getStepsText() -> String {
        var stepsString: String = ""
        recipeModel?.steps?.forEach({ ing in
            if let ingModel = ing as? Step {
                let rowString = "\(ingModel.number) \(String(describing: ingModel.stepDescription ?? "")) \n"
                stepsString.append(rowString)
            } else {}
        })
        return stepsString
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Sections(rawValue: indexPath.section)
        if section == .image {
            let cell: AddImageTableViewCell = tableView.dequeue(withIdentifier: AddImageTableViewCell.className, at: indexPath)
            if let imageData = recipeModel?.imageData {
                cell.addImageView.image = UIImage(data: imageData)
            } else {
                cell.addImageView.image = UIImage(named: Constants.defaultListImage)
            }
            cell.selectionStyle = .none
            return cell
        } else if section == .name {
            let cell: DetailRecipeNameTableViewCell = tableView.dequeue(withIdentifier: DetailRecipeNameTableViewCell.className, at: indexPath)
            cell.detailNameLabel.text = recipeModel?.name
            cell.selectionStyle = .none
            return cell
        } else if section == .ingredients {
            let cell: DetailRecipeNameTableViewCell = tableView.dequeue(withIdentifier: DetailRecipeNameTableViewCell.className, at: indexPath)
            cell.detailNameLabel.text = getIngredientsText()
            cell.selectionStyle = .none
            return cell
        } else if section == .steps {
            let cell: DetailRecipeNameTableViewCell = tableView.dequeue(withIdentifier: DetailRecipeNameTableViewCell.className, at: indexPath)
            cell.detailNameLabel.text = getStepsText()
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Sections(rawValue: indexPath.section) == .image {
            return 200
        } else if Sections(rawValue: indexPath.section) == .name {
            return 80
        } else if Sections(rawValue: indexPath.section) == .ingredients {
            //expanding
            return 130
        } else {
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle: String
        switch Sections(rawValue: section) {
        case .ingredients:
            sectionTitle = "Ingridents"
        case .steps:
            sectionTitle = "Steps"
        default:
            sectionTitle = ""
        }
        return sectionTitle
    }
}
