//
//  AnswersTableViewCellModel.swift
//  StackOverflowLite
//
//  Created by Max on 05/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import Foundation

class AnswersTableViewCellModel {

    private let answer: AnswerElement

    init(answer: AnswerElement) {
        self.answer = answer
    }

    var body: String {
        return answer.body
    }
}
