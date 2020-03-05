//
//  Question.swift
//  StackOverflowLite
//
//  Created by Max on 04/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import Foundation

// MARK: - Question
struct Question: Codable {
    let items: [Item]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

// MARK: - Item
struct Item: Codable {
    let tags: [String]
    let owner: Owner
    let isAnswered: Bool
    let viewCount, answerCount, score, lastActivityDate: Int
    let creationDate: Int
    let lastEditDate: Int?
    let questionID: Int
    let link: String
    let title: String
    let acceptedAnswerID, closedDate: Int?
    let closedReason: String?

    enum CodingKeys: String, CodingKey {
        case tags, owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case lastEditDate = "last_edit_date"
        case questionID = "question_id"
        case link, title
        case acceptedAnswerID = "accepted_answer_id"
        case closedDate = "closed_date"
        case closedReason = "closed_reason"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let reputation, userID: Int?
    let userType: UserType
    let profileImage: String?
    let displayName: String
    let link: String?
    let acceptRate: Int?

    enum CodingKeys: String, CodingKey {
        case reputation
        case userID = "user_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
        case acceptRate = "accept_rate"
    }
}

enum UserType: String, Codable {
    case doesNotExist = "does_not_exist"
    case registered = "registered"
}
