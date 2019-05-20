//
//  Rest.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 14/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

// Llamada a URL

public final class Rest {
  
  private static func connect<Element>(with urlRequest: URLRequest, type: Element.Type? = nil, completion: @escaping ((JSONResult<Element>) -> Void)) where Element: Codable  {
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      DispatchQueue.main.async {
        guard error == nil, let unwrappedData = data else {
          return completion(.error(userError: .serverError))
        }
        do {
          let decodedData = try JSONDecoder().decode(Element.self, from: unwrappedData)
          completion(.success(data: decodedData))
        } catch {
          return completion(.error(userError: .invalidJSON))
        }
      }
    }
    
    task.resume()
    
  }
  
  public static func get<Element>(endPoint: String, query: String? = nil, type: Element.Type, completion: @escaping ((JSONResult<Element>) -> Void)) where Element: Codable {
    let method = Method.get.rawValue
    let finalURLString = getFinalURLString(endPoint: endPoint, query: query)
    guard let urlRequest = generateRequest(with: finalURLString, method: method) else {
      return completion(.error(userError: .badURLFormat))
    }
    
    Rest.connect(with: urlRequest, type: type, completion: completion)
    
  }
  
  public static func post<Element>(endPoint: String, params: Data? = nil, type: Element.Type, completion: @escaping ((JSONResult<Element>) -> Void)) where Element: Codable {
    let method = Method.post.rawValue
    guard let urlRequest = generateRequest(with: endPoint, params: params, method: method) else {
      return completion(.error(userError: .badURLFormat))
    }
    
    Rest.connect(with: urlRequest, type: type, completion: completion)
  }
  
  public static func delete(endPoint: String, id: Int, completion: @escaping ((JSONResult<Nothing>) -> Void)) {
    let method = Method.delete.rawValue
    guard let urlRequest = generateRequest(with: endPoint, id: id, method: method) else {
      return completion(.error(userError: .badURLFormat))
    }
    
    Rest.connect(with: urlRequest, completion: completion)
  }
  
  public static func patch<Element>(endPoint: String, id: Int, params: Data? = nil, type: Element.Type? = nil, completion: @escaping ((JSONResult<Element>) -> Void)) where Element: Codable {
    let method = Method.patch.rawValue
    guard let urlRequest = generateRequest(with: endPoint, id: id, params: params, method: method) else {
      return completion(.error(userError: .badURLFormat))
    }
    
    Rest.connect(with: urlRequest, completion: completion)
    
  }
  
}
