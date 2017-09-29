//
//  DetailsViewController.swift
//  OGlobo
//
//  Created by Neto Moura on 25/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var labelTituloNoticia: UILabel!
    @IBOutlet weak var labelSubTituloNoticia: UILabel!
    @IBOutlet weak var labelAutor: UILabel!
    @IBOutlet weak var labelDataHoraPublicacao: UILabel!
    @IBOutlet weak var imagemNoticia: UIImageView!
    @IBOutlet weak var textoNoticia: UITextView!

    var image: UIImage?
    var titulo: String?
    var subTitulo: String?
    var autor: String?
    var dataHora: String?
    var texto: String?
    var tituloView: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = tituloView

        self.imagemNoticia.image = self.image
        self.labelTituloNoticia.text = self.titulo
        self.labelSubTituloNoticia.text = self.subTitulo
        self.labelAutor.text = self.autor
        self.labelDataHoraPublicacao.text = self.dataHora
        self.textoNoticia.text = self.texto

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
