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
    var cache = NSCache<AnyObject, AnyObject>()

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
                            self.arrayNoticias.append(noticia)
//                            if noticia.tipo != "linkExterno" {
//                            }
                        }
                    }
                self.mainTableView.reloadData()
                    
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                case .failure(let error):
                    print("ERRO! \(error)")
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
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
            let noticias = self.arrayNoticias[indexPath.row]
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "mainCell1", for: indexPath) as! MainTableViewCell1
            if (noticias.imagens?.isEmpty)! {
                cell1.imageViewNoticia1.image = UIImage(named: "default.png")
             } else {
                for item in noticias.imagens! {
                    if let image = cache.object(forKey: noticias.imagens?[0] as AnyObject) {
                        cell1.imageViewNoticia1.image = image as? UIImage
                    }else {
                        self.imagemNoticia = nil
                        Alamofire.request(item.url!).responseImage { response in
                            if let image = response.result.value {
                                cell1.imageViewNoticia1.image = image
                                self.cache.setObject(image, forKey: noticias.imagens?[0] as AnyObject)
                            }else{
                                print(response.description)
                            }
                        }
                    }
                }
            }
            cell1.labelNomeSecao1.text = noticias.secao?.nome?.uppercased()
            cell1.labelTituloNoticia1.text = noticias.titulo
            return cell1
            
        } else {
            let noticias = self.arrayNoticias[indexPath.row + 1]
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "mainCell2", for: indexPath) as! MainTableViewCell2
            if (noticias.imagens?.isEmpty)! {
                cell2.imageViewNoticia2.image = UIImage(named: "default.png")
            } else {
                
                for item in noticias.imagens! {
                    if let image = cache.object(forKey: noticias.imagens?[0] as AnyObject) {
                        cell2.imageViewNoticia2.image = image as? UIImage
                    }else {
                        cell2.imageViewNoticia2.image = nil
                        Alamofire.request(item.url!).responseImage { response in
                            if let image = response.result.value {
                                cell2.imageViewNoticia2.image = image
                                self.cache.setObject(image, forKey: noticias.imagens?[0] as AnyObject)
                            }else{
                                print(response.description)
                            }
                        }
                    }
                }

            }
            cell2.labelNomeSecao2.text = noticias.secao?.nome?.uppercased()
            cell2.labelTituloNoticia2.text = noticias.titulo
            return cell2
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainTableView.deselectRow(at: indexPath, animated: true)

        let DetailsVC: DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController

        if indexPath.section == 0 {
            DetailsVC.details = self.arrayNoticias[indexPath.row]
        } else {
            DetailsVC.details = self.arrayNoticias[indexPath.row + 1]
        }
        self.navigationController?.pushViewController(DetailsVC, animated: true)
    }

}
