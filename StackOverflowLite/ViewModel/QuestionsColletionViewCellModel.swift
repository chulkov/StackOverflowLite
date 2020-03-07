import Foundation

class QuestionsColletionViewCellModel {

    private let question: Item

    init(question: Item) {
        self.question = question
    }

    var title: String {
        return question.title
    }

    var ownerName: String {
        return question.owner.displayName
    }

    var userID: Int{
        return question.owner.userID ?? 0
    }
    
    var tagsInOneString: String {
        
        var tagsLabelText = ""
        for tag in question.tags{
            tagsLabelText.append("\(tag), ")
        }
        
        return String(tagsLabelText.dropLast(2))
    }
    var tagsArray: [String] {

        return question.tags
    }

    var profileImageURL: String {
        return question.owner.profileImage ?? ""
    }
    var score: String{
        return  String(question.score)
    }
    var body: String{
        return question.body
    }
    var questionID: Int{
        return question.questionID
    }
}
