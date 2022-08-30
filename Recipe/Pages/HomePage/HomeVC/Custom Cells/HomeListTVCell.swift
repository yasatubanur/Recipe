//
//  HomeListTVCell.swift
//  Recipe
//
//  Created by TUBANUR on 13.08.2022.
//

import UIKit

class HomeListTVCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeLabel.text = "a"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
