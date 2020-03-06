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
    @IBOutlet weak var authorStackView: UIStackView!
    
    // MARK: Properties
    public var questionsViewModel: QuestionsColletionViewCellModel?
    public let viewModel = ViewControllerViewModel()
    private var questionID : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let questionsViewModel = questionsViewModel{
            titleLabel.text = questionsViewModel.title.stripOutHtml()
            scoreLabel.text = questionsViewModel.score
            questionBodyLabel.attributedText =  try? NSAttributedString(htmlString: questionsViewModel.body)
            tagsLabel.text = questionsViewModel.tags
            authorNameLabel.text = questionsViewModel.ownerName
            avatarImage.imageFromServerURL(urlString: questionsViewModel.profileImageURL)
            questionID = questionsViewModel.questionID
        }
        
        tableView.register(UINib(nibName: "AnswerCell", bundle: nil), forCellReuseIdentifier: "AnswerCell")
        tableView.estimatedRowHeight = 165
        tableView.rowHeight = UITableView.automaticDimension
        
        viewModel.getAnswers(questionID: questionID ?? 0) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.authorViewTap(recognizer:)))
        authorStackView.addGestureRecognizer(recognizer)
        
    }
    @objc
    func authorViewTap(recognizer: UITapGestureRecognizer) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        profileViewController.modalPresentationStyle = .fullScreen
        profileViewController.userID = questionsViewModel?.userID
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "profileSegue" {
            
            if let destinationViewController = segue.destination as? ProfileViewController
            {
                let indexPath = self.tableView.indexPathForSelectedRow!
                let index = indexPath.row
                destinationViewController.answersViewModel = viewModel.cellTableViewModel(index: index)
                //destinationViewController.test = "index: \(index)"
            }
        }
        
    }
}
