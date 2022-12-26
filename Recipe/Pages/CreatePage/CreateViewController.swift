//
//  AddViewController.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 4.09.2022.
//

import UIKit
import CoreData

enum CreatePageType {
    case create
    case edit
}

fileprivate enum Sections: Int {
    case image = 0
    case name = 1
    case ingredients = 2
    case step = 3
}

class CreateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var createTableView: UITableView!
    
    var pageType: CreatePageType = .create
    
    private lazy var viewModel: CreateViewModelProtocol = {
        let viewModel = CreateViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func setupTableView() {
        createTableView.registerNib(withIdentifier: AddImageTableViewCell.className)
        createTableView.registerNib(withIdentifier: IngredientsTableViewCell.className)
        createTableView.registerNib(withIdentifier: AddItemTableViewCell.className)
        createTableView.registerNib(withIdentifier: StepTableViewCell.className)
        createTableView.registerNib(withIdentifier: RecipeNameTableViewCell.className)
        
        createTableView.delegate = self
        createTableView.dataSource = self
        createTableView.estimatedRowHeight = 50
    }
}


extension CreateViewController {
    
    @objc func doneAction() {
        viewModel.saveData()
        self.navigationController?.popViewController(animated: true)
    }
}


extension CreateViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .image:
            return 1
        case .ingredients:
            return viewModel.getIngredientsCount() + 1
        case .step:
            return viewModel.getStepArrayCount() + 1
        case .name:
            return 1
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Sections(rawValue: indexPath.section)
        if  section == .ingredients {
            if indexPath.row == viewModel.getIngredientsCount() {
                let cell: AddItemTableViewCell = tableView.dequeue(withIdentifier: AddItemTableViewCell.className, at: indexPath)
                let addItem = AddItemTableViewCell()
                addItem.createItemLabel?.text = "Create Item"
                cell.selectionStyle = .none
                return cell
            } else {
                let cell: IngredientsTableViewCell = tableView.dequeue(withIdentifier: IngredientsTableViewCell.className, at: indexPath)
                cell.ingredientsModel = viewModel.getIngredientModel(index: indexPath.row)
                cell.selectionStyle = .none
                return cell
            }
        } else if section == .step {
            if indexPath.row == viewModel.getStepArrayCount() {
                let cell: AddItemTableViewCell = tableView.dequeue(withIdentifier: AddItemTableViewCell.className, at: indexPath)
                cell.selectionStyle = .none
                return cell
            } else {
                let cell: StepTableViewCell = tableView.dequeue(withIdentifier: StepTableViewCell.className, at: indexPath)
                cell.stepModel = viewModel.getStepModel(index: indexPath.row)
                cell.selectionStyle = .none
                return cell
            }
        } else if section == .image {
            let cell: AddImageTableViewCell = tableView.dequeue(withIdentifier: AddImageTableViewCell.className, at: indexPath)
            cell.addImageView.image = viewModel.getImage()
            cell.selectionStyle = .none
            return cell
        } else if section == .name {
            let cell: RecipeNameTableViewCell = tableView.dequeue(withIdentifier: RecipeNameTableViewCell.className, at: indexPath)
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle: String
        switch Sections(rawValue: section) {
        case .name:
            sectionTitle = "Recipe Name"
        case .ingredients:
            sectionTitle = "Ingridents"
        case .step:
            sectionTitle = "Steps"
        default:
            sectionTitle = ""
        }
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        switch Sections(rawValue: section) {
        case .image:
            openImagePicker()
        case .ingredients:
            if indexPath.row == viewModel.getIngredientsCount() {
                viewModel.addIngredient(model: IngredientsModel())
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: viewModel.getIngredientsCount() - 1, section: Sections.ingredients.rawValue)], with: .bottom)
                tableView.endUpdates()
            }
            
        case .step:
            if indexPath.row == viewModel.getStepArrayCount() {
                let step = StepModel(number: viewModel.getStepArrayCount() + 1)
                viewModel.addStep(model: step)
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: viewModel.getStepArrayCount() - 1, section: Sections.step.rawValue)], with: .automatic)
                tableView.endUpdates()
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Sections(rawValue: indexPath.section) == .image {
            return 200
        } else if Sections(rawValue: indexPath.section) == .name {
            return 50
        }
        return UITableView.automaticDimension
    }
}


extension CreateViewController {
    
    func openImagePicker() {
        showAlert()
    }
    
    private func showAlert() {
        
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true) { [weak self] in
            
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            
            self?.viewModel.setImage(image: image)
            self?.createTableView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension CreateViewController: RecipeNameTableViewCellDelegate {
    
    func nameChanged(text: String) {
        if text.count < 1 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        viewModel.setRecipeName(name: text)
    }
}
