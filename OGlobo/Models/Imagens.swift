//
//  Imagens.swift
//  OGlobo
//
//  Created by Neto Moura on 27/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//


import Foundation
import AlamofireObjectMapper
import ObjectMapper

class Imagens: Mappable {
    
    var autor: String?
    var fonte: String?
    var legenda: String?
    var url: String?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        autor <- map["autor"]
        fonte <- map["fonte"]
        legenda <- map["legenda"]
        url <- map["url"]
    }
    
}
