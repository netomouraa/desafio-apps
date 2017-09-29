//
//  Secao.swift
//  OGlobo
//
//  Created by Neto Moura on 27/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class Secao: Mappable {
    
    var nome: String?
    var url: String?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        nome <- map["nome"]
        url <- map["url"]
    }
    
}
