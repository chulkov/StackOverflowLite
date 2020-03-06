//
//  DetailViewController+TableViewDelegate.swift
//  StackOverflowLite
//
//  Created by Max on 06/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITableView Delegate

extension DetailViewController  {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            performSegue(withIdentifier: "profileSegue", sender: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
