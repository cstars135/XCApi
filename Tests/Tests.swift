//
//  Tests.swift
//  Tests
//
//  Created by Cstars on 2017/3/24.
//  Copyright © 2017年 cstars. All rights reserved.
//

import XCTest
@testable import XCApi
//import ReactiveSwift
import Quick
import Nimble

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFetchCompanyChannelData() {
//        let service = Service(url: URL(string: "http://test.xincheng.tv/xinchengapi/index.php/api/Company/getList")!)
//        let producer = service.fetchCompanyChannelData(params: ["in_id": 22, "page": 0]).on(starting: {
//            
//        }, failed: { (error) in
//            
//        }, completed: {
//            print("completed")
//        }, interrupted: {
//            
//        }, value: {
//            print($0)
//        })
        
//        let observer = Observer<[XC_CompanyFoldModel], FetchDataError>()
//        producer.startWithResult { (res) in
//            print("1")
//            print(res)
//        }
    
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
