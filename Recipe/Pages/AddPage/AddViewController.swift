//
//  AddViewController.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 4.09.2022.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
    }
    
}


extension AddViewController {
    
    @objc func doneAction() {
    }
    
    @objc func backAction() {
    }
}
