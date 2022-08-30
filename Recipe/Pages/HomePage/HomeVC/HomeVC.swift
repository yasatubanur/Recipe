//
//  HomeVC.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listArray = ["asparagus","chicken","noodle","pasta","salad","sandwich","somon","shrimp","soup"]
    var images = ["asparagus.jpg","chicken.jpg","noodle.jpg","pasta.jpg","salad.jpg","sandwich.jpg","somon.jpg","shrimp.jpg","soup.jpg"]
    
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
        cell.recipeImage.image = UIImage(named: images[indexPath.row])
        cell.layer.masksToBounds = true
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 25
        cell.clipsToBounds = true
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 15
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.section).")
        }
    }

