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
    //let inspirations = Inspiration.allInspirations()
    
    
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
extension ViewControllerViewModel: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        
//        var detailVC: DetailViewController?
//       // detailVC?.viewModel = cellViewModel(index: indexPath.row)
//        detailVC?.text = "wow text"
//        detailVC?.performSegue(withIdentifier: "DetailSegue", sender: "text")
    }
}

// MARK: asynchronous networking code




// MARK: data preparation code for visual presentation


// MARK: code listening for Model changes
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
            print(error)
            return
        }
        DispatchQueue.main.async(execute: { () -> Void in
            let image = UIImage(data: data!)
            self.image = image
        })

    }).resume()
}}
