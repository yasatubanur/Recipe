//
//  ContentTableViewCell.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 8.10.2022.
//

import UIKit

protocol ContentTableViewCellProtocol: AnyObject {
    func buttonTapped()
}

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIView!
    
    weak var delegate: ContentTableViewCellProtocol?
    
    internal static func dequeue(fromTableView tableView: UITableView, atIndexPath indexPath: IndexPath) -> ContentTableViewCell {
        guard let cell: ContentTableViewCell = tableView.dequeue(withIdentifier: ContentTableViewCell.className, at: indexPath) as? ContentTableViewCell else {
            #if DEBUG
            fatalError("*** Failed to dequeue FromTheEditorsCell ***")
            #else
            return ContentTableViewCell()
            #endif
        }
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttonTapped(_ sender: Any) {
    }
    
}
