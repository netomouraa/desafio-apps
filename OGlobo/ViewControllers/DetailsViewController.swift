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
    @IBOutlet weak var labelDetailsImage: UILabel!
    @IBOutlet weak var textViewNoticia: UITextView!

    var details: Conteudos?
    var cache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = details?.secao?.nome?.uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightButtonAction(sender:)))
        
        if (details?.imagens?.isEmpty)! {
            self.imageViewNoticia.image = UIImage(named: "default.png")
        } else {
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
            self.labelDetailsImage.text = "\(item.legenda!). Foto: \(item.fonte!)"
            }
        }
        
        var autor: String?
        if details?.tipo == "linkExterno" || (details?.autores?.isEmpty)! {
            autor = "AUTOR DESCONHECIDO"
        } else {
            autor = details?.autores?[0]
        }

        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: "POR \(autor!.uppercased())")
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 60/255.0, green: 160/255.0, blue: 200.0/255.0, alpha: 1.0), range: NSRange(location:4,length:(autor?.characters.count)!))
        self.labelAutor.attributedText = myMutableString
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-0300"
        let date = dateFormatter.date(from: (details?.publicadoEm)!)!
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from: date)
        
        let dataString = NSMutableAttributedString(string: "")
        let image1Attachment = NSTextAttachment()
        let imageWatch = UIImage(named: "watch.png")
        image1Attachment.image = imageWatch
        let image1String = NSAttributedString(attachment: image1Attachment)
        dataString.append(image1String)
        dataString.append(NSAttributedString(string: " \(dateString)"))
        self.labelDataHoraPublicacao.attributedText = dataString
        
        self.labelTituloNoticia.text = details?.titulo
        self.labelSubTituloNoticia.text = details?.subTitulo
        self.textViewNoticia.text = details?.texto
    }
    
    func rightButtonAction(sender: UIBarButtonItem){
        let url = URL(string: (details?.urlOriginal)!)
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: [])
        activityController.popoverPresentationController?.sourceView = self.view
        activityController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(activityController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



