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
    private var answers: Answer?
    private var answerInfo: AnswerInfo?
    public var user: User?
    
    weak var customDelegate: CustomCollectionViewDelegate?
    
    //MARK: API Requests
    public func getQuestions(completion: (() -> Void)?) {
        networking.performNetworkTask(endpoint: StackOverflowAPI.questions,
                                      type: Question.self) { [weak self] (response) in
                                        self?.questions = response
                                        completion?()
        }
    }
    
    
    public func getAnswers(questionID: Int, completion: (() -> Void)?){
        networking.performNetworkTask(endpoint: StackOverflowAPI.answers(questionID: questionID), type: Answer.self){
            [weak self] (response) in
            self?.answers = response
            completion?()
        }
    }
    
    public func getAnswer(answerID: Int, completion: (() -> Void)?){
        networking.performNetworkTask(endpoint: StackOverflowAPI.answer(answerID: answerID), type: AnswerInfo.self) { [weak self] (response) in
            self?.answerInfo = response
            completion?()
        }
    }
    
    public func getUserByAnswerID(answerID: Int, completion: ((User) -> ())?){
        
        networking.performNetworkTask(endpoint: StackOverflowAPI.answer(answerID: answerID), type: AnswerInfo.self) { [weak self] (response) in
            self?.answerInfo = response
            self?.networking.performNetworkTask(endpoint: StackOverflowAPI.user(userID: self?.answerInfo?.elements[0].owner.userID ?? 0), type: User.self) { (response) in
                //self?.user = response
                //print(response)
                completion?(response)
            }
            
        }
    }
    public func getUser(userID: Int, completion: ((User) -> ())?){
        networking.performNetworkTask(endpoint: StackOverflowAPI.user(userID: userID), type: User.self) { (response) in
            completion?(response)
        }
    }

    
    // MARK: Prepare cells
    public func cellCollectionViewModel(index: Int) -> QuestionsColletionViewCellModel? {
        guard let questions = questions?.items?[index] else { return nil }
        let questionsColletionViewCellModel = QuestionsColletionViewCellModel(question: questions)
        return questionsColletionViewCellModel
    }
    
    public func cellTableViewModel(index: Int) -> AnswersTableViewCellModel? {
        guard let answers = answers else { return nil }
        guard let answer = answers.payload[0].answers?[index] else { return nil}
        let answersTableViewCellModel = AnswersTableViewCellModel(answer: answer)
        return answersTableViewCellModel
    }
    
    
    public var answersCount: Int {
        guard let answer = answers?.payload[0].answers else { return 0}
        return answer.count
    }
}


//MARK: CollectionView Data Source
extension ViewControllerViewModel: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let questions = questions?.items else { return 0 }
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InspirationCell.reuseIdentifier, for: indexPath)
            as? InspirationCell else {
                return UICollectionViewCell()
        }
        cell.viewModel = cellCollectionViewModel(index: indexPath.row)
        return cell
    }
    
}
//MARK: CollectionView Delegate
extension ViewControllerViewModel: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }
}


// MARK: String extensions
extension NSAttributedString {
    convenience init(htmlString html: String) throws {
        try self.init(data: Data(html.utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)
    }
    
}

extension String {
    
    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
