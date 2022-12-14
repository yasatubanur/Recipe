//
//  AddViewController.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 4.09.2022.
//

import UIKit
import CoreData

enum Sections: Int {
    case image = 0
    case name = 1
    case ingredients = 2
    case step = 3
}

class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var addTableView: UITableView!
    
    var recipeModel: RecipeModel = RecipeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
    }
    
    func setupTableView() {
        addTableView.registerNib(withIdentifier: AddImageTableViewCell.className)
        addTableView.registerNib(withIdentifier: IngredientsTableViewCell.className)
        addTableView.registerNib(withIdentifier: AddItemTableViewCell.className)
        addTableView.registerNib(withIdentifier: StepTableViewCell.className)
        addTableView.registerNib(withIdentifier: RecipeNameTableViewCell.className)
        
        addTableView.delegate = self
        addTableView.dataSource = self
        addTableView.estimatedRowHeight = 50
    }
}


extension AddViewController {
    
    @objc func doneAction() {
        
        let recipe = Recipe(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContext)
        recipe.name = recipeModel.recipeName
        recipe.imageData = recipeModel.selectedImage?.pngData()
        recipe.id = UUID()
        
        recipeModel.ingridentsArray.forEach { addingIng in
            let ing = Ingredient(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContext)
            ing.id = UUID()
            ing.amount = Double(addingIng.amount)
            ing.typeString = addingIng.amountType.rawValue
            ing.name = addingIng.name
            recipe.addToIngredients(ing)
        }
        
        recipeModel.stepArray.forEach { addingStep in
            let step = Step(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContext)
            step.id = UUID()
            step.number = Int16(addingStep.stepNumber)
            step.stepDescription = addingStep.stepDescription
            recipe.addToSteps(step)
        }
        
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func backAction() {
    }
}


extension AddViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .image:
            return 1
        case .ingredients:
            return recipeModel.ingridentsArray.count + 1
        case .step:
            return recipeModel.stepArray.count + 1
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
            if indexPath.row == recipeModel.ingridentsArray.count {
                let cell: AddItemTableViewCell = tableView.dequeue(withIdentifier: AddItemTableViewCell.className, at: indexPath)
                let addItem = AddItemTableViewCell()
                addItem.addItemLabel?.text = "Add Item"
                
                return cell
            } else {
                let cell: IngredientsTableViewCell = tableView.dequeue(withIdentifier: IngredientsTableViewCell.className, at: indexPath)
              
                cell.ingredientsModel = recipeModel.ingridentsArray[indexPath.row]
                return cell
            }
        } else if section == .step {
            if indexPath.row == recipeModel.stepArray.count {
                let cell: AddItemTableViewCell = tableView.dequeue(withIdentifier: AddItemTableViewCell.className, at: indexPath)
                
                return cell
            } else {
                let cell: StepTableViewCell = tableView.dequeue(withIdentifier: StepTableViewCell.className, at: indexPath)
                cell.stepModel = recipeModel.stepArray[indexPath.row]
                
                return cell
            }
        } else if section == .image {
            let cell: AddImageTableViewCell = tableView.dequeue(withIdentifier: AddImageTableViewCell.className, at: indexPath)
            cell.addImageView.image = recipeModel.selectedImage ?? UIImage(systemName: "minus")
            return cell
        } else if section == .name {
            let cell: RecipeNameTableViewCell = tableView.dequeue(withIdentifier: RecipeNameTableViewCell.className, at: indexPath)
            cell.delegate = self
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
    
   /* func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    */
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
            if indexPath.row == recipeModel.ingridentsArray.count {
                recipeModel.ingridentsArray.append(IngredientsModel())
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: recipeModel.ingridentsArray.count - 1, section: Sections.ingredients.rawValue)], with: .bottom)
                tableView.endUpdates()
            }
            
        case .step:
            if indexPath.row == recipeModel.stepArray.count {
                recipeModel.stepArray.append(StepModel(number: recipeModel.stepArray.count + 1))
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: recipeModel.stepArray.count - 1, section: Sections.step.rawValue)], with: .automatic)
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


extension AddViewController {
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

        //get image from source type
        private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

            //Check is source type available
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {

                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = sourceType
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }

        //MARK:- UIImagePickerViewDelegate.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            self.dismiss(animated: true) { [weak self] in

                guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            
                self?.recipeModel.selectedImage = image
                self?.addTableView.reloadData()
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}


extension AddViewController: RecipeNameTableViewCellDelegate {
    
    func nameChanged(text: String) {
        recipeModel.recipeName = text
    }
}
