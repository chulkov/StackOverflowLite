//
//  AnswerCell.swift
//  StackOverflowLite
//
//  Created by Max on 05/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {

    @IBOutlet weak var answerBodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var viewModel: AnswersTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            answerBodyLabel.text = viewModel.body
            answerBodyLabel.attributedText =  try? NSAttributedString(htmlString: viewModel.body)
        }
    }
    
}
