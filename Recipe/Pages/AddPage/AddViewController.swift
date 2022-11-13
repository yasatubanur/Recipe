//
//  AddViewController.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 4.09.2022.
//

import UIKit

class AddViewController: UIViewController {
    
    

    @IBOutlet weak var addTableView: UITableView!
    var ingArray = ["bir eleman"]
    var stepArray = ["heloooooo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
    }
    
    func setupTableView() {
        addTableView.registerNib(withIdentifier: AddImageTableViewCell.className)
        addTableView.registerNib(withIdentifier: ContentTableViewCell.className)
        addTableView.registerNib(withIdentifier: AddItemTableViewCell.className)
        
        addTableView.delegate = self
        addTableView.dataSource = self
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
            return ingArray.count
        case 1:
            return stepArray.count
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let section = indexPath.section
        
        if indexPath.section == 0 {
            if indexPath.row == ingArray.count-1 {
                let cell: AddItemTableViewCell = tableView.dequeue(withIdentifier: AddItemTableViewCell.className, at: indexPath)
                return cell
            } else {
                let cell: ContentTableViewCell = tableView.dequeue(withIdentifier: ContentTableViewCell.className, at: indexPath)
                return cell
            }
        } else {
            if indexPath.row == stepArray.count-1 {
                let cell: AddItemTableViewCell = tableView.dequeue(withIdentifier: AddItemTableViewCell.className, at: indexPath)
                return cell
            } else {
                let cell: ContentTableViewCell = tableView.dequeue(withIdentifier: ContentTableViewCell.className, at: indexPath)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
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
        case 0:
            sectionTitle = "Ingridents"
        case 1:
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
            if indexPath.row == ingArray.count-1 {
                ingArray.append("new")
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                tableView.endUpdates()
            }
            
        case 1:
            if indexPath.row == stepArray.count-1 {
                stepArray.append("new")
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
                tableView.endUpdates()
            }
        default:
            print("")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
