//
//  DetailViewController+TableViewDataSource.swift
//  StackOverflowLite
//
//  Created by Max on 05/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import Foundation

import UIKit

// MARK: - UITableView Data Source

extension DetailViewController  {
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            print("answer numberOfRowsInSection   \(viewModel.answersCount)")
            return viewModel.answersCount
            //the datasource of the dynamic section
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            var recognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit(recognizer:)))
//             // Add gesture recognizer to your image view
//             cell.yourimageview.addGestureRecognizer(recognizer)
//        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as! AnswerCell
            cell.viewModel = viewModel.cellTableViewModel(index: indexPath.row)
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
        return UITableView.automaticDimension
    }
}
