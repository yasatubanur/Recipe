//
//  StepTableViewCell.swift
//  Recipe
//
//  Created by Tuba Nur YAŞA on 15.11.2022.
//

import UIKit

class StepTableViewCell: UITableViewCell {

    @IBOutlet weak var stepNumberLabel: UILabel?
    @IBOutlet weak var recipeTextView: UITextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    var stepModel: StepModel? {
        didSet {
            let number = stepModel?.stepNumber ?? 1
            stepNumberLabel?.text = "Step \(number): "
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        recipeTextView.layer.borderColor = CGColor(red: 204.0/255.0, green:204.0/255.0, blue:204.0/255.0, alpha:1.0)
        recipeTextView.layer.borderWidth = 2.0
        recipeTextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension StepTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        stepModel?.stepDescription = recipeTextView.text
        let size = recipeTextView.sizeThatFits(CGSize(width: recipeTextView.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if size.height != textViewHeightConstraint.constant && size.height > recipeTextView.frame.size.height{
            textViewHeightConstraint.constant = size.height
            recipeTextView.setContentOffset(CGPoint.zero, animated: false)
        }
    }
}
