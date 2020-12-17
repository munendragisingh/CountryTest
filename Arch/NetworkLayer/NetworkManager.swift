//
//  NetworkManager.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import Foundation

class NetworkManager {
    public static let main = NetworkManager()
    private init() {}
    
    /// this method will handle POST request
    /// - Parameters:
    ///   - url: URL
    ///   - params: params
    ///   - file: if there is any file to be uploaded
    ///   - fileType: mem type
    ///   - complition: complition
    func requestToServer(request: URLRequest, complition:@escaping(_ data: Data?, _ responce: URLResponse?, _ error: Error?) -> Void){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            complition(data, response, error)
        }
        task.resume()
    }
}
