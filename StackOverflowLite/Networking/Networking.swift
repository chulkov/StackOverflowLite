//
//  Networking.swift
//  NetworkingLayer
//
//  Created by Arturs Derkintis on 01/11/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation


struct Networking {

    func performNetworkTask<T: Codable>(endpoint: StackOverflowAPI,
                                        type: T.Type,
                                        completion: ((_ response: T) -> Void)?) {
        let urlString = endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
        guard let urlRequest = URL(string: urlString ?? "") else { return }
        print(urlRequest)
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let error = error {
                print("URL: \(error)")
                return
            }
            guard let data = data else {
                return
            }
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
              // TODO: show alert, unit test
                print("error response decoding")
                return
            }
            completion?(decoded)
        }
        urlSession.resume()
    }

}
