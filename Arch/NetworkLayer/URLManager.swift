//
//  URLManager.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import Foundation

class URLManager {
    private let baseURL: String = "https://dl.dropboxusercontent.com/"
    var countyFacts: String {
        return baseURL + "s/2iodh4vg0eortkl/facts.json"
    }
}
