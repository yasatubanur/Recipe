//
//  HomeVC.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = HomeViewModel()
    private enum Constants {
        static let pageTitle = "RECIPE"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    @objc func addAction() {
        
    }
}

//MARK: - tableView -
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HomeListTableViewCell.dequeue(fromTableView: tableView, atIndexPath: indexPath)

        cell.recipeLabel.text = viewModel.getRecipeName(index: indexPath.row)
        cell.recipeImage.image = UIImage(named: viewModel.getImage(index: indexPath.row))
       
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

