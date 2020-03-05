//
//  DetailViewController.swift
//  StackOverflowLite
//
//  Created by Max on 05/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    
    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var questionBodyLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    // MARK: Properties
    public var viewModel: QuestionsColletionViewCellModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel{
            titleLabel.text = viewModel.title
            scoreLabel.text = viewModel.score
            questionBodyLabel.text = viewModel.body
            tagsLabel.text = viewModel.tags
            authorNameLabel.text = viewModel.ownerName
            
        }
        
        tableView.register(UINib(nibName: "AnswerCell", bundle: nil), forCellReuseIdentifier: "AnswerCell")
        tableView.estimatedRowHeight = 165
        tableView.rowHeight = UITableView.automaticDimension
    }
}
