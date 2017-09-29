//
//  DetailsViewController.swift
//  OGlobo
//
//  Created by Neto Moura on 25/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {

    @IBOutlet weak var labelTituloNoticia: UILabel!
    @IBOutlet weak var labelSubTituloNoticia: UILabel!
    @IBOutlet weak var labelAutor: UILabel!
    @IBOutlet weak var labelDataHoraPublicacao: UILabel!
    @IBOutlet weak var imageViewNoticia: UIImageView!
    @IBOutlet weak var textViewNoticia: UITextView!

    var details: Conteudos?
    var cache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = details?.secao?.nome?.uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        
        for item in (details?.imagens!)! {
            if let image = cache.object(forKey: self.details?.imagens![0] as AnyObject) {
                self.imageViewNoticia.image = image as? UIImage
            }else {
                self.imageViewNoticia.image = nil
                Alamofire.request(item.url!).responseImage { response in
                    if let image = response.result.value {
                        self.imageViewNoticia.image = image
                        self.cache.setObject(image, forKey: self.details?.imagens![0] as AnyObject)
                    }else{
                        print(response.description)
                    }
                }
            }
        }
        
        var autor: String?
        if (details?.autores)! != [] {
            autor = details?.autores?[0]
        } else {
            autor = "AUTOR"
        }


        var myString:NSString = autor! as NSString
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location:2,length:4))
        // set label Attribute
        self.labelAutor.attributedText = myMutableString
        
        self.labelTituloNoticia.text = details?.titulo
        self.labelSubTituloNoticia.text = details?.subTitulo
        self.labelAutor.text = "POR \(autor!.uppercased())"
        self.labelDataHoraPublicacao.text = details?.publicadoEm
        self.textViewNoticia.text = details?.texto

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



