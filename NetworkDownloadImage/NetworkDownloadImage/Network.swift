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

final class NetworkService: NSObject {
    
    private var session: URLSession
    private var bgSession: URLSession
    
    private lazy var bgConfiguration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "background")
        configuration.sessionSendsLaunchEvents = true
        configuration.isDiscretionary = true
        configuration.allowsCellularAccess = true
        configuration.shouldUseExtendedBackgroundIdleMode = true
        configuration.waitsForConnectivity = true
        return configuration
    }()
    
    init(configuration: URLSessionConfiguration? = nil, bgConfiguration: URLSessionConfiguration? = nil) {
        if let bgConfiguration = bgConfiguration {
            self.bgSession = URLSession(configuration: bgConfiguration)
        }
        else {
            self.bgSession = URLSession(configuration: URLSessionConfiguration.default)
        }
        
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: URLSessionConfiguration.default)
        }
    }
    
    func start(url: String) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        
        let task = bgSession.downloadTask(with: request)
        task.countOfBytesClientExpectsToSend = 512
        task.countOfBytesClientExpectsToReceive = 10 * 1024 * 1024
        task.resume()
    }
}

//MARK: INetworkService
extension NetworkService: INetworkService {
    
    func loadData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        let task = self.session.downloadTask(with: request) { data, response, error in
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
        }
        DispatchQueue.main.async {
            
            
            let appDelegate = AppDelegate()
            appDelegate.bgSessionCompletionHandler = {
                task.cancel() { data in
                    let task: URLSessionDownloadTask
                    if let data = data {
                        task = self.bgSession.downloadTask(withResumeData: data)
                    } else {
                        task = self.bgSession.downloadTask(with: request) { url, response, error in
                            if let error = error {
                                completion(.failure(error))
                            }
                            
                            if let url = url {
                                if let result = try? Data(contentsOf: url) {
                                    completion(.success(result))
                                }
                            }
                        }
                    }
                    task.resume()
                }
                
            }
            
        }
        task.resume()
    }
    
}


extension NetworkService: URLSessionDelegate {
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
    }
}



