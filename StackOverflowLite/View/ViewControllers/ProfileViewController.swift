//
//  ProfileViewController.swift
//  StackOverflowLite
//
//  Created by Max on 06/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    public var answersViewModel: AnswersTableViewCellModel?
    
    //MARK: IBOutlets
    
    @IBOutlet weak var parentStackView: UIStackView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var goldBadgeLabel: UILabel!
    @IBOutlet weak var silverBadgeLabel: UILabel!
    @IBOutlet weak var bronzeBadgeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    public let viewModel = ViewControllerViewModel()
    private var answerID : Int?
    
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let answersViewModel = answersViewModel{
            answerID = answersViewModel.answerID
        }
        
        parentStackView.isHidden = true
        
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        
        viewModel.getUserByAnswerID(answerID: answerID ?? 0) { (user) in
            
            DispatchQueue.main.async {
                self.nameLabel.text = user.objects[0].displayName
                self.avatarImageView.imageFromServerURL(urlString: user.objects[0].profileImage ?? "")
                self.reputationLabel.text = String(user.objects[0].reputation ?? 0)
                self.goldBadgeLabel.text = String(user.objects[0].badgeCounts.gold )
                self.silverBadgeLabel.text = String(user.objects[0].badgeCounts.silver )
                self.bronzeBadgeLabel.text = String(user.objects[0].badgeCounts.bronze )
                self.activityIndicator.stopAnimating()
                self.parentStackView.isHidden = false
            }
            // print(user)
        }
        
        
        
        
        
    }
    
}
