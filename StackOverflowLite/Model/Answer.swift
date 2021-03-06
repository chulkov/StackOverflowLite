//
//  Answer.swift
//  StackOverflowLite
//
//  Created by Max on 05/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import Foundation

// MARK: - Answer
struct Answer: Codable {
    let payload: [Payload]
    enum CodingKeys: String, CodingKey {
        case payload = "items"
    }
}

// MARK: - Item
struct Payload: Codable {
    let comments: [Comment]?
    let answers: [AnswerElement]?
    let commentCount, lastActivityDate, questionID: Int
    let link: String
    let title, body: String
    
    enum CodingKeys: String, CodingKey {
        case comments, answers
        case commentCount = "comment_count"
        case lastActivityDate = "last_activity_date"
        case questionID = "question_id"
        case link, title, body
    }
}

// MARK: - AnswerElement
struct AnswerElement: Codable {
    let commentCount, answerID: Int
    let link: String
    let body: String
    let comments: [Comment]?
    
    enum CodingKeys: String, CodingKey {
        case commentCount = "comment_count"
        case answerID = "answer_id"
        case link, body, comments
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.commentCount = (try? container.decode(Int.self, forKey: .commentCount)) ?? 0
        self.answerID = (try? container.decode(Int.self, forKey: .answerID)) ?? 0
        self.link = (try? container.decode(String.self, forKey: .link)) ?? ""
        self.body = (try? container.decode(String.self, forKey: .body)) ?? ""
        self.comments = (try? container.decode([Comment].self, forKey: .comments)) ?? []
    }
}

// MARK: - Comment
struct Comment: Codable {
    let link: String
    let body: String
}
