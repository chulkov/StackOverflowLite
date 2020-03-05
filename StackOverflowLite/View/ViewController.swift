//
//  ViewController.swift
//  StackOverflowLite
//
//  Created by Max on 04/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    
    //MARK: Properties
    
    
    
    fileprivate let viewModel = ViewControllerViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = viewModel
        let layout = collectionView.collectionViewLayout as? CustomCollectionViewLayout
        layout?.delegate = viewModel as? CustomCollectionViewDelegate
        
        
        
        viewModel.getQuestions {
            DispatchQueue.main.async {
                //self?.tableView.reloadData()
                self.collectionView.reloadData()
            }
        }
        
    }
    
    
    //MARK: IBActions
    
    
    
    //MARK: Update UI
    
    //from ViewModel
}
