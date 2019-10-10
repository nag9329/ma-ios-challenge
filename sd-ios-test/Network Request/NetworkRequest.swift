//
//  NetworkRequest.swift
//  sd-ios-test
//
//  Created by Nagarjuna Ramagiri on 10/7/19.
//  Copyright © 2019 Slickdeals, LLC. All rights reserved.
//

import Foundation

/// Network manager that is used to create all the network requests in the application
class NetworkRequest {
    public static let shared = NetworkRequest()
    private init() {}
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
       jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
       return jsonDecoder
    }()
    public enum NetworkRequestError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    func fetchDeals<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkRequestError>) -> Void) {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
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
                case .failure(_):
                    completion(.failure(.apiError))
                }
         }.resume()
    }
}

// MARK: CustomURLSession
extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
