//
//  Conteudo.swift
//  OGlobo
//
//  Created by Neto Moura on 27/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class Conteudos: Mappable {
    
    var autores: [String]?
    var informePublicitario: Bool?
    var subTitulo: String?
    var texto: String?
    var videos: [Videos]?
    var atualizadoEm: String?
    var id: Int?
    var publicadoEm: String?
    var secao: Secao?
    var tipo: String?
    var titulo: String?
    var url: String?
    var urlOriginal: String?
    var imagens: [Imagens]?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        autores <- map["autores"]
        informePublicitario <- map["informePublicitario"]
        subTitulo <- map["subTitulo"]
        texto <- map["texto"]
        videos <- map["videos"]
        atualizadoEm <- map["atualizadoEm"]
        id <- map["id"]
        publicadoEm <- map["publicadoEm"]
        secao <- map["secao"]
        tipo <- map["tipo"]
        titulo <- map["titulo"]
        url <- map["url"]
        urlOriginal <- map["urlOriginal"]
        imagens <- map["imagens"]

    }
    
}
