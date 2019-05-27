//
//  NetworkService.swift
//  CTD_Test
//
//  Created by Busarov, Arthur on 5/25/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init(){}
    
    private func getRequestTemplate(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(Credentials.shared.apiKey, forHTTPHeaderField: "'x-api-key")
        return request
    }
    
    //Basic GET  request
    func doGetRequest(withUrl: String,
                      completition: @escaping (_ result: Data?, _ error: Error?) -> Void ) {
        guard let url = URL(string: withUrl) else { return }
        var request = getRequestTemplate(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            completition(data, error)
        }).resume()
    }
    
    //Basic POST request
    func doPostRequest(withUrl: String,
                       data: [String: Any],
                       completition: @escaping (_ result: Data?, _ error: Error?) -> Void ) {
        guard let url = URL(string: withUrl) else { return }
        var request = getRequestTemplate(url: url)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: data, options: []) else { return }
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request, completionHandler:  { (data, response, error) in
            completition(data, error)
        }).resume()
    }
}
