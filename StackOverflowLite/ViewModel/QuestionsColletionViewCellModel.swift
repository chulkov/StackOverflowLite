//
//  RepoTableViewCellModel.swift
//  NetworkingLayer
//
//  Created by Arturs Derkintis on 01/11/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

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

    var tags: [String] {
        return question.tags
    }

    var profileImage: String {
        return question.owner.profileImage ?? ""
    }
}
