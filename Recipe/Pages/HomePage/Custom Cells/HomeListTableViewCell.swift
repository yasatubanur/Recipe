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
    
    internal static func dequeue (fromTableView tableView: UITableView, atIndexPath indexPath: IndexPath) -> HomeListTableViewCell {
        guard let cell: HomeListTableViewCell = tableView.dequeue(withIdentifier: HomeListTableViewCell.className, at: indexPath) as?
                HomeListTableViewCell else {
                    #if DEBUG
                    fatalError("*** Failed to dequeue FromTheEditorCell ***")
                    #else
                    return HomeListTableViewCell()
                    #endif
                }
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        imageView?.layer.cornerRadius = 30
        imageView?.clipsToBounds = true
        imageView?.layer.masksToBounds = true
    }
}
