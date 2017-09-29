//
//  Conteudo.swift
//  OGlobo
//
//  Created by Neto Moura on 27/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import Foundation

class Conteudo {
    
    var events: [Events]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        events <- map["events"]
    }
    
}
