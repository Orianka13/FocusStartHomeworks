//
//  Network.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import Foundation

protocol INetworkService {
    func loadData(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService {
    
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration? = nil) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: URLSessionConfiguration.default)
        }
    }
}

//MARK: INetworkService
extension NetworkService: INetworkService {
    
    func loadData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return }

        let request = URLRequest(url: url)
        self.session.downloadTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let result = try Data(contentsOf: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}


