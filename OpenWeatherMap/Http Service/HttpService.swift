//
//  HttpService.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

class HttpService: NSObject {
    
    var urlSession: URLSession?
    
    override init() {
        super.init()
        
        urlSession = .init(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
    }
    
    func clearURLSession() {
        urlSession?.invalidateAndCancel()
    }
    
    func process(request: URLRequest, completionHandler: @escaping (Response) -> Void) {
        processCall(request: request, completionHandler: completionHandler)
    }
    
    private func processCall(request: URLRequest, completionHandler: @escaping (Response) -> Void) {
        urlSession?.dataTask(with: request, completionHandler: { [completion = completionHandler] data, response, error in
            let responseData = data
            let responseCode = (response as? HTTPURLResponse)?.statusCode
            
            let response: Response = .init(
                data: responseData,
                code: responseCode,
                error: error as? CustomError
            )
            
            completion(response)
        }).resume()
    }
}

extension HttpService: URLSessionTaskDelegate, URLSessionDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(request)
    }
}
