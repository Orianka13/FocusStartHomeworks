//
//  Network.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import Foundation

protocol INetworkService {
    
    var fileLocation: ((String) -> ())? { get set }
    var onProgress: ((Double) -> ())? { get set }
    var getData: ((Data) -> ())? { get set }
    var getError: ((Error?) -> ())? { get set }
    
    func loadData(url: String)
}

final class NetworkService: NSObject {
    
    private enum Literal {
        static var sessionId = "background"
        static var downloadProgress = "Download progress: "
    }
    
    private enum Metrics {
        static var timeoutIntervalForResource = TimeInterval(300)
        static var countOfBytesClientExpectsToSend = Int64(512)
        static var countOfBytesClientExpectsToReceive = Int64(10 * 1024 * 1024)
    }
    
    private var downloadTask: URLSessionDownloadTask?
    var fileLocation: ((String) -> ())?
    var onProgress: ((Double) -> ())?
    var getData: ((Data) -> ())?
    var getError: ((Error?) -> ())?
    
    private lazy var bgSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: Literal.sessionId)
        config.timeoutIntervalForResource = Metrics.timeoutIntervalForResource
        config.waitsForConnectivity = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
}

extension NetworkService: INetworkService {
    
    func loadData(url: String) {
        if let url = URL(string: url) {
            self.downloadTask = bgSession.downloadTask(with: url)
            self.downloadTask?.countOfBytesClientExpectsToSend = Metrics.countOfBytesClientExpectsToSend
            self.downloadTask?.countOfBytesClientExpectsToReceive = Metrics.countOfBytesClientExpectsToReceive
            self.downloadTask?.resume()
        }
    }
}

extension NetworkService: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
        DispatchQueue.main.async {
            let appDelegate = AppDelegate()
            guard
                let completionHandler = appDelegate.bgSessionCompletionHandler
            else { return }
            
            appDelegate.bgSessionCompletionHandler = nil
            completionHandler()
        }
    }
}

extension NetworkService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        DispatchQueue.main.async {
            self.fileLocation?(location.absoluteString)
        }
        do {
            let data = try Data(contentsOf: location)
            self.getData?(data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        print(Literal.downloadProgress, progress)
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
    }
}

extension NetworkService: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            self.getError?(error)
        }
    }
}

