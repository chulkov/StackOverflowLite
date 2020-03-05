//
//  DetailViewController.swift
//  StackOverflowLite
//
//  Created by Max on 05/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    public var viewModel: QuestionsColletionViewCellModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel{
            testLabel.text = viewModel.title
        }
        
    }

}
