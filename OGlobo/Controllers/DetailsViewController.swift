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

        navigationItem.title = tituloView?.uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)

//        let myMutableString = NSMutableAttributedString()
//            
//        let myLabel = UILabel()
//        let myString = self.autor!
//        
//        myLabel.text = myString
//
//        myMutableString.addAttribute(
//            NSFontAttributeName,
//            value: UIFont(
//                name: "WalbaumDisplay-Bold",
//                size: 12.0)!,
//            range: NSRange(
//                location:0,
//                length:1))
//        myMutableString.addAttribute(
//            NSForegroundColorAttributeName,
//            value: UIColor.blue,
//            range: NSRange(
//                location:0,
//                length:1))
    
        
//        let lbl = UILabel()
//        let txt = self.autor
//        let attrs = [NSFontAttributeName : UIFont(name: "WalbaumDisplay-Bold", size: 12)]
//        let attributedString = NSMutableAttributedString(string: txt!, attributes: attrs)
//        
//        lbl.textColor = UIColor.blue
//        lbl.attributedText = attributedString
        

//        let yourAttributes = [NSForegroundColorAttributeName: UIColor.blue, NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
//        let partOne = NSMutableAttributedString(string: self.autor!, attributes: yourAttributes)
//        
//
//        let combination = NSMutableAttributedString()
//        combination.append(partOne)
//        
//                let lbl = UILabel()
//        
//                lbl.attributedText = combination

        
        self.imagemNoticia.image = self.image
        self.labelTituloNoticia.text = self.titulo
        self.labelSubTituloNoticia.text = self.subTitulo
        self.labelAutor.text = "POR \(self.autor!.uppercased())"
        self.labelDataHoraPublicacao.text = self.dataHora
        self.textoNoticia.text = self.texto

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



