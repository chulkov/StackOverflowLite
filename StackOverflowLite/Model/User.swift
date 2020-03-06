//
//  User.swift
//  StackOverflowLite
//
//  Created by Max on 06/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import Foundation

// MARK: - User
struct User: Codable {
    let objects: [Object]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case objects = "items"
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

// MARK: - Item
struct Object: Codable {
    let badgeCounts: BadgeCounts
    let accountID: Int
    let isEmployee: Bool
    let lastModifiedDate, lastAccessDate, reputationChangeYear, reputationChangeQuarter: Int?
    let reputationChangeMonth, reputationChangeWeek, reputationChangeDay, reputation: Int?
    let creationDate: Int
    let userType: String
    let userID: Int
    let location, websiteURL: String?
    let link: String?
    let profileImage: String?
    let displayName: String?

    enum CodingKeys: String, CodingKey {
        case badgeCounts = "badge_counts"
        case accountID = "account_id"
        case isEmployee = "is_employee"
        case lastModifiedDate = "last_modified_date"
        case lastAccessDate = "last_access_date"
        case reputationChangeYear = "reputation_change_year"
        case reputationChangeQuarter = "reputation_change_quarter"
        case reputationChangeMonth = "reputation_change_month"
        case reputationChangeWeek = "reputation_change_week"
        case reputationChangeDay = "reputation_change_day"
        case reputation
        case creationDate = "creation_date"
        case userType = "user_type"
        case userID = "user_id"
        case location
        case websiteURL = "website_url"
        case link
        case profileImage = "profile_image"
        case displayName = "display_name"
    }
}

// MARK: - BadgeCounts
struct BadgeCounts: Codable {
    let bronze, silver, gold: Int
}
