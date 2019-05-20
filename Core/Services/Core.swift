//
//  Core.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 14/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

public typealias JSONObject = [String: Any]

public enum UserError: Error {
  case invalidJSON
  case serverError
  case badURLFormat
  case internalError
}

public enum JSONResult<Element> {
  case success(data: Element)
  case error(userError: UserError)
  
  public func result() -> Result<Element> {
    switch self {
    case .success(let data):
      return .success(data: data)
    case .error(let error):
      return .error(userError: error)
    }
  }
}

public enum Result<Element> {
  case success(data: Element)
  case error(userError: UserError)
  case loading
}

public enum Content<Element> {
  case loading
  case empty
  case success(data: Element)
  case error(userError: UserError)
}

public struct Nothing: Codable {}

public enum Method: String {
  case get = "GET"
  case post = "POST"
  case delete = "DELETE"
  case patch = "PATCH"
}

private func createRequest(string: String, id: Int? = nil) -> URLRequest? {
  var string = string
  if let id = id {
    string += "/\(id)"
  }
  guard let url = URL(string: string) else { return nil }
  let urlRequest = URLRequest(url: url)
  return urlRequest
}

public func generateRequest(with string: String, id: Int? = nil,  params: Data? = nil, method: String? = nil) -> URLRequest? {
  guard var urlRequest = createRequest(string: string, id: id) else { return nil }
  urlRequest.httpMethod = method
  urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
  urlRequest.httpBody = params

  return urlRequest
}

public func getFinalURLString(endPoint: String, query: String? = nil) -> String {
  if let query = query {
    return endPoint + query
  }
  return endPoint
}
