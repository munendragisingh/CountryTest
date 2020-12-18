//
//  CountryViewModel.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import Foundation

class CountryViewModel {
    private let country: Country
    
    var imgUrl: String {
        return self.country.image ?? ""
    }
    
    var title: String {
        return self.country.title ?? ""
    }
    
    var description: String {
        return self.country.description ?? ""
    }
    
    init(country: Country) {
        self.country  = country
    }
}

