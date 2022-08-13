//
//  HomeVC.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listArray = ["lemon","banana","watermelon","strawberry","grape"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editTableView()
        editNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    
    @objc func addAction() {
        
    }
    
    func editNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(addAction))
        self.navigationController!.navigationBar.barStyle = .default
        self.navigationController!.navigationBar.isTranslucent = true
        self.title = "RECIPE"
    }
    
    func editTableView() {
        tableView.register(UINib(nibName: "HomeListTVCell", bundle: nil), forCellReuseIdentifier: "HomeListTVCell")

        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - tableView
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListTVCell", for: indexPath) as! HomeListTVCell

        cell.recipeLabel.text = listArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
}
