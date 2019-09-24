//
//  RequestManager.swift
//  testApi
//
//  Created by Yury Popov on 24/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation

enum UserError: Error {
    case noDataAvalible
    case canNotProcessData
}

struct RequestManager {
    private let apiToken = "P2nFvXi-VY-248kz2t"
    private let url = URL(string: "https://bnet.i-partner.ru/testAPI/")
    private var request: URLRequest!
    static var session: String!
    static var shared = RequestManager()
    
    init() {
        request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue(apiToken, forHTTPHeaderField: "token")
    }
    
    mutating func newSession() {
        
        let params = "a=new_session"
        request.httpBody = params.data(using: .utf8, allowLossyConversion: true)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            if let str = String(data: data, encoding: .utf8) {
                RequestManager.session = String(str.dropFirst(31).dropLast(3))
            }
        }.resume()
        
    }
    
    mutating func getRequest(newSession: String,completion: @escaping(Result<UserEntrys, UserError>) -> Void) {
        
        let params = "a=get_entries&session=\(newSession)"
        request.httpBody = params.data(using: .utf8, allowLossyConversion: true)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            do {
                let decoder = JSONDecoder()
                let usersResponse = try decoder.decode(UserEntrys.self, from: data)
                let userDetails = usersResponse
                completion(.success(userDetails))
            } catch {
                completion(.failure(.canNotProcessData))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    mutating func addEntry(body: String, newSession: String) {
        
        let params = "a=add_entry&session=\(newSession)&body=\(body)"
        request.httpBody = params.data(using: .utf8, allowLossyConversion: true)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard data != nil else { print("Empty data"); return }
        }.resume()
    }
}
