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
    case user(login: String)
}

extension StackOverflowAPI: EndpointType {
    var baseURL: URL {
        return URL(string: "https://api.stackexchange.com")!
    }

    var path: String {
        switch self {
        case .questions:
            return "/questions?site=stackoverflow&filter=withbody"
        case .user(let login):
            return "/users/\(login)"
        }
    }
}
