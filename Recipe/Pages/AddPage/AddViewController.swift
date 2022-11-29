//
//  AddViewController.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 4.09.2022.
//

import UIKit

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
        
        addTableView.delegate = self
        addTableView.dataSource = self
        addTableView.estimatedRowHeight = 50
    }
}


extension AddViewController {
    
    @objc func doneAction() {
    }
    
    @objc func backAction() {
    }
}


extension AddViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return recipeModel.ingridentsArray.count + 1
        case 2:
            return recipeModel.stepArray.count + 1
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
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
        } else if indexPath.section == 2 {
            if indexPath.row == recipeModel.stepArray.count {
                let cell: AddItemTableViewCell = tableView.dequeue(withIdentifier: AddItemTableViewCell.className, at: indexPath)
                
                return cell
            } else {
                let cell: StepTableViewCell = tableView.dequeue(withIdentifier: StepTableViewCell.className, at: indexPath)
                cell.stepModel = recipeModel.stepArray[indexPath.row]
                
                return cell
            }
        } else {
            let cell: AddImageTableViewCell = tableView.dequeue(withIdentifier: AddImageTableViewCell.className, at: indexPath)
            cell.addImageView.image = recipeModel.selectedImage
            return cell
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
        switch section {
        case 1:
            sectionTitle = "Ingridents"
        case 2:
            sectionTitle = "Steps"
        default:
            sectionTitle = ""
        }
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        switch section {
        case 0:
            openImagePicker()
        case 1:
            if indexPath.row == recipeModel.ingridentsArray.count {
                recipeModel.ingridentsArray.append(IngredientsModel())
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: recipeModel.ingridentsArray.count - 1, section: 1)], with: .bottom)
                tableView.endUpdates()
            }
            
        case 2:
            if indexPath.row == recipeModel.stepArray.count {
                recipeModel.stepArray.append(StepModel(number: recipeModel.stepArray.count + 1))
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: recipeModel.stepArray.count - 1, section: 2)], with: .automatic)
                tableView.endUpdates()
            }
        default:
            print("")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
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

