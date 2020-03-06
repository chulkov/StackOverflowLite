//
//  AnswerInfo.swift
//  StackOverflowLite
//
//  Created by Max on 06/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import Foundation

// MARK: - AnswerInfo
struct AnswerInfo: Codable {
    let elements: [Element]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case elements = "items"
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

// MARK: - Item
struct Element: Codable {
    let owner: Owner
    let isAccepted: Bool
    let score, lastActivityDate, lastEditDate, creationDate: Int?
    let answerID, questionID: Int

    enum CodingKeys: String, CodingKey {
        case owner
        case isAccepted = "is_accepted"
        case score
        case lastActivityDate = "last_activity_date"
        case lastEditDate = "last_edit_date"
        case creationDate = "creation_date"
        case answerID = "answer_id"
        case questionID = "question_id"
    }
}
