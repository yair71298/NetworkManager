//
//  File.swift
//  
//
//  Created by yair Ivnizki on 13/10/2021.
//

import Foundation
class RequestWitCclosure{
    static func request<T : Decodable>(_ url: String,_ ofType: T.Type, listener: @escaping (T?, Error?) -> ()){
        let url = URL(string: url)!
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    listener(decoded, nil)
                } catch let error{
                    listener(nil, error)
                }
            }else{
                listener(nil, error)
            }
        }
        dataTask.resume()
    }
}
