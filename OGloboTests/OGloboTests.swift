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
    
    func testExample() {
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
    
    func testParsesData() {
//        let promise = expectation(description: "Status code: 200")
        var noticias = [String]()
        
        XCTAssertEqual(noticias.count, 0, "numbers of elements in array")
        let dataTask = sessionUnderTest?.dataTask(with: urlAPI!) {
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
//                    promise.fulfill()
                    
                    do {
                        if let data = data,
                            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                            let conteudos = json["conteudos"] as? [[String: Any]] {
                            for item in conteudos {
                                if let noticia = item["titulo"] as? String {
                                    noticias.append(noticia)
                                }
                            }
                        }
                        print(noticias)
                    } catch {
                        print("Error deserializing JSON: \(error)")
                    }
//                    for item in data!{
//                        print("ITEM: \(item)")
//                        for noticia in item.conteudos!{
//                            self.mainViewController.arrayNoticias.append(noticia)
//                        }
//                    }
                }
            }
        }
        dataTask?.resume()
//        waitForExpectations(timeout: 5, handler: nil)
//
//        XCTAssertEqual(noticias.count, 14, "Numbers of elements in array")
    }
}

extension UIViewController {

    func preload() {
        _ = self.view
    }

}

