//
//  OGloboTests.swift
//  OGloboTests
//
//  Created by Neto Moura on 25/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//
import XCTest
//import Alamofire

@testable import OGlobo

class OGloboTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    var mainViewController: MainViewController!
    let urlAPI = URL(string: "https://raw.githubusercontent.com/Infoglobo/desafio-apps/master/capa.json")
    
    override func setUp() {
        super.setUp()
        
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
        mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVC") as! MainViewController
        mainViewController.preload()
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testPerformanceExample() {
        self.measure {
            self.mainViewController.requestAlamofire()
        }
    }
    
    func testValidCallToAPIGetsHTTPStatusCode200() {
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: urlAPI!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCallToAPICompletes() {
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: urlAPI!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
//    func testDadosEstaoSendoApresentadosCorretamente() {
//        mainViewController.arrayNoticias = [Conteudos]()
//        mainViewController.mainTableView.reloadData()
//
//        let indiceCell1 = IndexPath(row: 0, section: 0)
//        let primeiraCell = mainViewController.mainTableView?.cellForRow(at: indiceCell1) as! MainTableViewCell1
//
//        let indiceCell2 = IndexPath(row: 1, section: 1)
//        let segundaCell = mainViewController.mainTableView?.cellForRow(at: indiceCell2) as! MainTableViewCell2
//
//        let indiceCell3 = IndexPath(row: 2, section: 1)
//        let terceiraCell = mainViewController.mainTableView?.cellForRow(at: indiceCell3) as! MainTableViewCell2
//
//        XCTAssertEqual(primeiraCell.labelNomeSecao1.text, "O GLOBO", "Dados corretos na primeira célula")
//        XCTAssertEqual(segundaCell.labelNomeSecao2.text, "Mariana Sanches", "Dados corretos na segunda célula")
//        XCTAssertEqual(terceiraCell.labelNomeSecao2.text, "Maria Lima", "Dados corretos na terceira célula")
//
//    }
    
    
//    func testAoClicarNaCelulaDeveIrParaTelaDeDetalhes() {
//        mainViewController.arrayNoticias = [Conteudos]()
//        mainViewController.mainTableView.reloadData()
//
//        mainViewController.mainTableView.delegate?.tableView!(mainViewController.mainTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
//
//        XCTAssertTrue(self.navigationController.topViewController is DetailsViewController)
//    }
    
    
//    func testRequest() {
//        let e = expectation(description: "Alamofire")
//
//        Alamofire.request(urlAPI!)
//            .response { response in
//                XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
//
//                XCTAssertNotNil(response, "No response")
//                XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
//
//                e.fulfill()
//        }
//
//        waitForExpectations(timeout: 5.0, handler: nil)
//    }

}

extension UIViewController {

    func preload() {
        _ = self.view
    }

}

