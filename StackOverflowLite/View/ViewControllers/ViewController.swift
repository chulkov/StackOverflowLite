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
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: Properties
    fileprivate let viewModel = ViewControllerViewModel()
    
    var refresher: UIRefreshControl!
    
    fileprivate func getQuestions() {
        viewModel.getQuestions {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = viewModel
        let layout = collectionView.collectionViewLayout as? CustomCollectionViewLayout
        layout?.delegate = viewModel as? CustomCollectionViewDelegate
        
        getQuestions()
        
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        //self.collectionView!.addSubview(refresher)
        collectionView.refreshControl = refresher
        
    }
    
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        viewModel.getQuestions {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refresher.endRefreshing()
            }
        }
        
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            
            if let destinationViewController = segue.destination as? DetailViewController
            {
                let indexPath = self.collectionView.indexPathsForSelectedItems?.first
                let index = indexPath?.row
                destinationViewController.questionsViewModel = viewModel.cellCollectionViewModel(index: index ?? 0)
            }
        }
        
    }
}
