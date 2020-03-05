//
//  DetailViewController.swift
//  StackOverflowLite
//
//  Created by Max on 05/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    public var viewModel: QuestionsColletionViewCellModel?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel{
            testLabel.text = viewModel.title
        }
        
        tableView.register(UINib(nibName: "AnswerCell", bundle: nil), forCellReuseIdentifier: "AnswerCell")
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                if section == 1 {
            return 5
            //the datasource of the dynamic section
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as! AnswerCell
            return cell
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
                if indexPath.section == 1 {
            let newIndexPath = IndexPath(row: 0, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
        }
        return super.tableView(tableView, indentationLevelForRowAt: indexPath )
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 44
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
