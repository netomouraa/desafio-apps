//
//  Videos.swift
//  OGlobo
//
//  Created by Neto Moura on 27/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class Videos: Mappable {
    
//    var title: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
//        title <- map["title"]
    }
    
}
