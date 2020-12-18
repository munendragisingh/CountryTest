//
//  MockSeccion.swift
//  ArchTests
//
//  Created by Munendra Singh on 19/12/20.
//

import Foundation
class URLProtocolMock: URLProtocol {
    
    static var testURLs = [URL?: String]()
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let fileName = URLProtocolMock.testURLs[url] {
                let bundle = Bundle(for: type(of: self))
                let urlPath = bundle.path(forResource: fileName, ofType: "json")
                guard let path = urlPath else { return }
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    self.client?.urlProtocol(self, didLoad: data)
                } catch let err {
                    self.client?.urlProtocol(self, didFailWithError: err)
                }
            }
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() { }
}
