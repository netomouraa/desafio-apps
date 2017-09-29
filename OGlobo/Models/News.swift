//
//  News.swift
//  OGlobo
//
//  Created by Neto Moura on 26/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class News: Mappable {
    
    var conteudos: [Conteudos]?
    var produto: String?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        conteudos <- map["conteudos"]
        produto <- map["produto"]
    }
    
}
