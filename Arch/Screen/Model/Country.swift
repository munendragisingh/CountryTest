//
//  Country.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import Foundation

struct CountryListData: Decodable {
    var title: String?
    var countries:Array<Country>?
    
    enum CodingKeys: String, CodingKey {
        case title
        case countries = "rows"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.countries = try container.decodeIfPresent(Array<Country>.self, forKey: .countries)
        self.countries = self.countries?.filter {
            ($0.title != nil)
        }
        print("")
    }
}

struct Country: Decodable {
    var title: String?
    var description: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case image = "imageHref"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
    }
    
}
