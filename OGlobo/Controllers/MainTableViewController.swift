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

class MainTableViewController: UITableViewController {
    
    
    @IBOutlet weak var imageHeader: UIImageView!
    var arrayNoticias = [Conteudos]()
    var imagemNoticia = [UIImage]()
    var urlImagem = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        requestAlamofire()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestAlamofire() {
        
//        self.activityIndicator.startAnimating()
//        UIApplication.shared.beginIgnoringInteractionEvents()
        
        Alamofire.request(RouterOGlobo.desafioApps)
            .validate().responseArray { (response: DataResponse<[News]>) in
                switch response.result {
                case .success(let data):
                    print("DATA: \(data)")
                    
                    for itens in data{
                        for noticia in itens.conteudos!{
                            
                            print("NOTICIA: \(noticia.titulo)")

                            if noticia.tipo != "linkExterno" {
                                self.arrayNoticias.append(noticia)

                                for item in noticia.imagens!{
                                    DispatchQueue.main.async() {
                                        print("FOTO: \(item.url!)\n")
                                        //                                        self.urlImagem.append(item.url!)
                                        //                                        print("url: \(self.urlImagem.count)")
                                        self.requestImagem(url: item.url!)
                                    }
                                }
                            } 
//                                else {
//                                print("FOTOVAZIA")
//                                self.imagemNoticia.append(UIImage(named: "default.png")!)
//                            }
                        }
                    }
                    
                    self.tableView.reloadData()

//                    self.activityIndicator.stopAnimating()
//                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    
                case .failure(let error):
                    print("ERRO! \(error)")
                    
//                    self.activityIndicator.stopAnimating()
//                    UIApplication.shared.endIgnoringInteractionEvents()
                }
        }
        
    }
    
    func requestImagem( url: String) {
        Alamofire.request(url).responseImage { response in
            switch response.result {
            case .success(let data):

            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
                print("image downloaded: \(data)")
                self.imagemNoticia.append(data)

            case .failure(let error):

                print(error)

            }
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayNoticias.count - 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        
        
        print(self.imagemNoticia)
        
        for (index, element) in self.arrayNoticias.enumerated() {
            
            if index == 0 {
                
                if self.imagemNoticia.count != 0 {
                    let image = self.imagemNoticia[0]
                    self.imageHeader.image = image
                }
                
            } else {
                
                let noticias = self.arrayNoticias[indexPath.row]
                
                if self.imagemNoticia.count != 0 {
                    let image = self.imagemNoticia[indexPath.row]
                    cell.imageViewNoticia.image = image
                    
                }
                
                print("titulos: \(self.arrayNoticias.count)")
                print("IMAGEM: \(self.imagemNoticia.count)")
                
                
                cell.labelNomeSecao.text = noticias.secao?.nome
                cell.labelTituloNoticia.text = noticias.titulo
                
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let noticias = self.arrayNoticias[indexPath.row]
        let image = self.imagemNoticia[indexPath.row]
        var autor = ""
        
        if noticias.autores != nil {
            autor = noticias.autores!.first!
        }
        
        let DetailsVC: DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        
        DetailsVC.image = image
        DetailsVC.titulo = noticias.titulo
        DetailsVC.subTitulo = noticias.subTitulo
        DetailsVC.autor = "POR \(autor)"
        DetailsVC.dataHora = noticias.publicadoEm
        DetailsVC.texto = noticias.texto
        DetailsVC.tituloView = noticias.secao?.nome
        
        self.navigationController?.pushViewController(DetailsVC, animated: true)
    }



}
