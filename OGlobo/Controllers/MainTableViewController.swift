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
    
    @IBOutlet weak var mainTableView: UITableView!

    var arrayNoticias = [Conteudos]()
    var imagemNoticia: UIImage?
//    var urlImagem = [String]()
    
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
                            }
                        }
                    }
                    
                    DispatchQueue.main.async() {
                        self.mainTableView.reloadData()
                    }

//                                for item in noticia.imagens!{
                            
                                    
                                    
//                                    DispatchQueue.main.async() {
//                                        print("FOTO: \(item.url!)\n")
//                                        //                                        self.urlImagem.append(item.url!)
//                                        //                                        print("url: \(self.urlImagem.count)")
//                                        self.requestImagem(url: item.url!)
//                                    }
//                                }
//                            }
//                                else {
//                                print("FOTOVAZIA")
//                                self.imagemNoticia.append(UIImage(named: "default.png")!)
//                            }
                    

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

//            debugPrint(response)
//            
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
            
                print("image downloaded: \(data)")
                self.imagemNoticia = data

            case .failure(let error):

                print(error)

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
        
        if indexPath.section == 0 {

            let cell1 = tableView.dequeueReusableCell(withIdentifier: "mainCell1", for: indexPath) as! MainTableViewCell1
            
            var noticias = self.arrayNoticias.first!

            for item in noticias.imagens! {
                requestImagem(url: item.url!)
            }
            
            cell1.imageViewNoticia1.image = self.imagemNoticia
            cell1.labelNomeSecao1.text = noticias.secao?.nome?.uppercased()
            cell1.labelTituloNoticia1.text = noticias.titulo

            return cell1
        } else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "mainCell2", for: indexPath) as! MainTableViewCell2
            
            var noticias = self.arrayNoticias[indexPath.row + 1]
    
            for item in noticias.imagens! {
                requestImagem(url: item.url!)
            }

            cell2.imageViewNoticia2.image = self.imagemNoticia
            cell2.labelNomeSecao2.text = noticias.secao?.nome?.uppercased()
            cell2.labelTituloNoticia2.text = noticias.titulo
            
            return cell2
        }
        
//        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainTableView.deselectRow(at: indexPath, animated: true)
        
        let noticias = self.arrayNoticias[indexPath.row]
        var autor = ""
        
        
        if noticias.autores != nil {
            autor = noticias.autores!.first!
        }
        
        let DetailsVC: DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        
        DetailsVC.image = self.imagemNoticia
        DetailsVC.titulo = noticias.titulo
        DetailsVC.subTitulo = noticias.subTitulo
        DetailsVC.autor = autor
        DetailsVC.dataHora = noticias.publicadoEm
        DetailsVC.texto = noticias.texto
        DetailsVC.tituloView = noticias.secao?.nome
        
        self.navigationController?.pushViewController(DetailsVC, animated: true)
    }



}
