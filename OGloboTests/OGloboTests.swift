//
//  OGloboTests.swift
//  OGloboTests
//
//  Created by Neto Moura on 25/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import XCTest
@testable import OGlobo

class OGloboTests: XCTestCase {
    
    var mainViewController: MainViewController!
    var mainsTableViewCell1: MainTableViewCell1!
    var Conteudo: Conteudos!
    
    override func setUp() {
        super.setUp()
        
        mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVC") as! MainViewController
        mainViewController.preload()

        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNumeroDeItensDaTabelaDeveSerIgualAQuantidadeDeDadosDoArray() {
//        mainViewController.arrayNoticias = [Conteudos(titulo:"Maria", subTitulo:"da Silva")]
        mainViewController.arrayNoticias = [Conteudos]()
        mainViewController.mainTableView.reloadData()
        
//        XCTAssertEqual(mainsTableViewCell1.labelTituloNoticia1.text!, "Pessoas carregadas")

//        let indiceCell1 = IndexPath(forRow: 0, inSection: 0)
//        let primeiraCell = mainViewController.mainTableView?.cellForRow(at: indiceCell1 as IndexPath) as! MainTableViewCell1
//
//        XCTAssertEqual(primeiraCell.labelTituloNoticia1.text, "Sr(a) Maria - 20 anos", "Dados incorretos na primeira célula")
    }
    
}


extension UIViewController {
    
    func preload() {
        _ = self.view
    }
    
}
