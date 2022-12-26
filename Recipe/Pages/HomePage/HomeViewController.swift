//
//  HomeViewController.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import UIKit
import CoreData

protocol HomeViewControllerProtocol {
    func reloadData()
}

fileprivate enum  Sections: Int {
    case search = 0
    case recipes = 1
}

class HomeViewController: UIViewController, HomeViewControllerProtocol {
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: HomeViewModelProtocol = {
        let viewModel = HomeViewModel()
        viewModel.viewController = self
        return viewModel
    }()
    
    private enum Constants {
        static let pageTitle = "RECIPE"
        static let defaultImage = "listRecipeImage"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.readData()
    }
    
    func reloadData() {
        if viewModel.getRecipeCount() == 0 {
            emptyLabel.isHidden = false
            emptyLabel.text = " There are no recipes to show, add new one"
        } else {
            emptyLabel.isHidden = true
        }
        tableView.reloadSections([Sections.recipes.rawValue], with: .none)
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(addAction))
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.title = Constants.pageTitle
    }
    
    private func registerCells() {
        tableView.registerNib(withIdentifier: HomeListTableViewCell.className)
        tableView.registerNib(withIdentifier: FilterTableViewCell.className)
    }
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - Actions -
extension HomeViewController {
    
    @objc func addAction() {
        let createViewController = CreateViewController.loadFromNib()
        createViewController.pageType = .create
        navigationController?.pushViewController(createViewController, animated: true)
    }
}

//MARK: - tableView -
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Sections(rawValue: indexPath.section)
        if section == .search {
            let cell: FilterTableViewCell = tableView.dequeue(at: indexPath)
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else {
            let cell: HomeListTableViewCell = tableView.dequeue(at: indexPath)
            cell.selectionStyle = .none
            
            cell.recipeLabel.text = viewModel.getRecipeName(index: indexPath.row)
            if let image = viewModel.getImage(index: indexPath.row) {
                cell.recipeImage.image = UIImage(data: image)
            } else {
                cell.recipeImage.image = UIImage(named: Constants.defaultImage)
            }
            
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Sections(rawValue: section)
        if section == .search {
            return 1
        } else if section == .recipes {
            return viewModel.getRecipeCount()
        }
            return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Sections(rawValue: indexPath.section), section == .recipes else { return }
        let detailViewController = DetailViewController.loadFromNib()
        detailViewController.recipeModel = viewModel.getRecipeModel(index: indexPath)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = Sections(rawValue: indexPath.section)
        if section == .search {
            return 40
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let section = Sections(rawValue: indexPath.section), section == .recipes else { return }
        if editingStyle == .delete {
            viewModel.removeRecipe(index: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


extension HomeViewController: FilterTableViewCellDelegate {
    
    func search(text: String) {
        viewModel.filter(text: text)
    }
}
