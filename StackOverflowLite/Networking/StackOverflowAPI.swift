//
//  GitHubAPI.swift
//  NetworkingLayer
//
//  Created by Arturs Derkintis on 01/11/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation

enum StackOverflowAPI {
    case questions
    case answers(questionID: Int)
    case answer(answerID: Int)
    case user(userID: Int)
}

extension StackOverflowAPI: EndpointType {
    var baseURL: URL {
        return URL(string: "https://api.stackexchange.com")!
    }

    var path: String {
        switch self {
        case .questions:
            return "/questions?site=stackoverflow&filter=withbody"
        case .answers(let questionID):
            return "/questions/\(String(questionID))?site=stackoverflow&filter=!-y(KwOdKR5Ga7mmruVArx2SJykc-M)3jKiDQBk1fq"
        case .answer(let answerID):
            return "/answers/\(String(answerID))?site=stackoverflow"
        case .user(let userID):
            return "/users/\(String(userID))?site=stackoverflow"
        }
        
    }
}
