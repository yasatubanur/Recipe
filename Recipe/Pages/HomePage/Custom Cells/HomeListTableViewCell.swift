//
//  HomeListTVCell.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        imageView?.layer.cornerRadius = 30
        imageView?.clipsToBounds = true
        imageView?.layer.masksToBounds = true
    }
}
