//
//  ApiManager.swift
//  EngineerAi_Test
//
//  Created by Александр  on 9/30/19.
//  Copyright © 2019 GoToInc. All rights reserved.
//

import Foundation

//protocol ResponceProtocol {}
//protocol ResponceError {}

protocol APIProtocol {
  //  func fetchPosts(with page: Int, result: @escaping (Result<ResponceProtocol, ResponceError>) -> Void)
}


class ApiManager: APIProtocol {
    
    public static let shared = ApiManager()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=1")!
    
    
    private let jsonDecoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
       jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-mm-dd"
       jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
       return jsonDecoder
    }()
    
  
   
    
    
    private func fetchResources<T: Decodable>(page: Int, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
     
        urlSession.dataTask(with: url) { (result) in
            switch result {
                case .success(let (response, data)):
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    do {
                        
                        let values = try self.jsonDecoder.decode(T.self, from: data)
                        completion(.success(values))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                case .failure(let error):
                    completion(.failure(.apiError))
                }
         }.resume()
    }
    
     public func fetchPosts(with page: Int, result: @escaping (Result<PostResponse, APIServiceError>) -> Void) {
    
        fetchResources(page: page, completion: result)
    }
}


extension ApiManager {
    
    
    public struct PostResponse: Codable {
        
        public let page: Int
        public let totalResults: Int
        public let totalPages: Int
        public let results: [Post]
    }
   
    
    
    public enum APIServiceError: Error {
             case apiError
             case invalidEndpoint
             case invalidResponse
             case noData
             case decodeError
         }
}


