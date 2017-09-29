//
//  MainTableViewController.swift
//  OGlobo
//
//  Created by Neto Moura on 25/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mainTableView: UITableView!

    var arrayNoticias = [Conteudos]()
    var imagemNoticia: UIImage?
//    var urlImagem = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        requestAlamofire()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestAlamofire() {
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        Alamofire.request(RouterOGlobo.desafioApps)
            .validate().responseArray { (response: DataResponse<[News]>) in
                switch response.result {
                case .success(let data):
                    for itens in data{
                        for noticia in itens.conteudos!{
                            if noticia.tipo != "linkExterno" {
                                self.arrayNoticias.append(noticia)
                            }
                        }
                    }
                    DispatchQueue.main.async() {
                        self.mainTableView.reloadData()
                    }
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                case .failure(let error):
                    print("ERRO! \(error)")
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
        }
    }
    
    func requestImagem( url: String) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                
                self.imagemNoticia = image
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return 230
        } else {
            return 115
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayNoticias.count != 0 {
            if section == 0 {
                return 1
            } else {
                return self.arrayNoticias.count - 1
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var noticias = self.arrayNoticias[indexPath.row]

        if indexPath.section == 0 {
            noticias = self.arrayNoticias.first!
            for item in noticias.imagens! {
                self.requestImagem(url: item.url!)
            }
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "mainCell1", for: indexPath) as! MainTableViewCell1
            cell1.imageViewNoticia1.image = self.imagemNoticia
            cell1.labelNomeSecao1.text = noticias.secao?.nome?.uppercased()
            cell1.labelTituloNoticia1.text = noticias.titulo
            return cell1
        } else {
            for item in noticias.imagens! {
                self.requestImagem(url: item.url!)
            }

            let cell2 = tableView.dequeueReusableCell(withIdentifier: "mainCell2", for: indexPath) as! MainTableViewCell2
            cell2.imageViewNoticia2.image = self.imagemNoticia
            cell2.labelNomeSecao2.text = noticias.secao?.nome?.uppercased()
            cell2.labelTituloNoticia2.text = noticias.titulo
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainTableView.deselectRow(at: indexPath, animated: true)
        
        var noticias = self.arrayNoticias[indexPath.row]
        let imagem = self.imagemNoticia

        var autor = ""
        
        if noticias.autores != nil {
            autor = noticias.autores!.first!
        }

        if indexPath.section == 0 {
            noticias = self.arrayNoticias.first!

        } else {
        
        }

        let DetailsVC: DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        DetailsVC.image = imagem
        DetailsVC.titulo = noticias.titulo
        DetailsVC.subTitulo = noticias.subTitulo
        DetailsVC.autor = autor
        DetailsVC.dataHora = noticias.publicadoEm
        DetailsVC.texto = noticias.texto
        DetailsVC.tituloView = noticias.secao?.nome
        self.navigationController?.pushViewController(DetailsVC, animated: true)
    }

}
