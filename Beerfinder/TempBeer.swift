//
//  TempBeer.swift
//  Beerfinder
//
//  Created by Kachi Nwaobasi on 3/25/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import Foundation
import SwiftyJSON

enum BeerSizeType : Int {
    case single = 1, sixPack = 6, twelvePack = 12
}

struct BeerSize {
    var image: String
    var type: BeerSizeType
    var price: Double
}

class TempBeer {
    
    var name: String!
    var type: String!
    var price: Double!
    var popularity: Int!
    var company: String!
    var manufacturer: String!
    var cityOfOrigin: String?
    var introduced: Int?
    var alcoholByVolume: Double!
    
    var sizes: [BeerSize]!
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.type = json["type"].stringValue
        self.price = json["price"].doubleValue
        self.popularity = json["popularity"].intValue
        self.company = json["company"].stringValue
        self.manufacturer = json["manufacturer"].stringValue
        self.cityOfOrigin = json["city-of-origin"].stringValue
        self.introduced = json["introduced"].int
        self.alcoholByVolume = json["abv"].doubleValue
        
        sizes = [BeerSize]()
        for jsonSize in json["sizes"].arrayValue {
            sizes.append(BeerSize(image: jsonSize["image"].stringValue, type: BeerSizeType(rawValue: jsonSize["type"].intValue)!, price: jsonSize["price"].doubleValue))
        }
    }
}
