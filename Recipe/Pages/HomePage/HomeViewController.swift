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

class HomeViewController: UIViewController, HomeViewControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: HomeViewModelProtocol = {
        let viewModel = HomeViewModel()
        viewModel.viewController = self
        return viewModel
    }()
    
    private enum Constants {
        static let pageTitle = "RECIPE"
        static let defaultImage = "minus"
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
        tableView.reloadData()
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
        let addVC = AddViewController.loadFromNib()
        navigationController?.pushViewController(addVC, animated: true)
    }
}

//MARK: - tableView -
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HomeListTableViewCell = tableView.dequeue(at: indexPath)
        
        cell.recipeLabel.text = viewModel.getRecipeName(index: indexPath.row)
        if let image = viewModel.getImage(index: indexPath.row) {
            cell.recipeImage.image = UIImage(data: image)
        } else {
            cell.recipeImage.image = UIImage(systemName: Constants.defaultImage)
        }
       
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRecipeCount()
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
    }
}

