//
//  ViewModel.swift
//  StackOverflowLite
//
//  Created by Max on 04/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import Foundation
import UIKit


/*ViewController view model*/
class ViewControllerViewModel: NSObject {
    
    private let networking = Networking()
    
    private var questions: Question?
    weak var customDelegate: CustomCollectionViewDelegate?
    let inspirations = Inspiration.allInspirations()
    
    
    public func getQuestions(completion: (() -> Void)?) {
        networking.performNetworkTask(endpoint: StackOverflowAPI.questions,
                                      type: Question.self) { [weak self] (response) in
                                        self?.questions = response
                                        completion?()
        }
    }
    
    public func cellViewModel(index: Int) -> QuestionsColletionViewCellModel? {
        guard let questions = questions else { return nil }
        let questionsColletionViewCellModel = QuestionsColletionViewCellModel(question: questions.items[index]) //RepoTableViewCellModel(repo: repos.items[index])
        return questionsColletionViewCellModel
    }
}








extension ViewControllerViewModel: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InspirationCell.reuseIdentifier, for: indexPath)
            as? InspirationCell else {
                return UICollectionViewCell()
        }
        cell.viewModel = cellViewModel(index: indexPath.row)
        return cell
    }
    
}

// MARK: asynchronous networking code




// MARK: data preparation code for visual presentation


// MARK: code listening for Model changes
