//
//  HomeVC.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = HomeViewModel()

    private enum Constants {
        static let pageTitle = "RECIPE"
    }
    
    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readData()
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
extension HomeVC {
    
    func readData() {
        do {
            let request = Recipe.fetchRequest() as NSFetchRequest<Recipe>
            
            let recipes = try AppDelegate.sharedAppDelegate.coreDataStack.managedContext.fetch(request)
            print(recipes)
            self.recipes = recipes
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    @objc func addAction() {
        let addVC = AddViewController.loadFromNib()
        navigationController?.pushViewController(addVC, animated: true)
    }
}

//MARK: - tableView -
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      //  let cell = HomeListTableViewCell.dequeue(fromTableView: tableView, atIndexPath: indexPath)
        let cell: HomeListTableViewCell = tableView.dequeue(at: indexPath)
        
        cell.recipeLabel.text = recipes[indexPath.row].name
        if let data = recipes[indexPath.row].imageData {
            cell.recipeImage.image = UIImage(data: data)
        }
       
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
    }
}

