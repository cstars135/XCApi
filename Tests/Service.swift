//
//  Service.swift
//  XCApi
//
//  Created by Cstars on 2017/3/27.
//  Copyright © 2017年 cstars. All rights reserved.
//

import Foundation
import Quick
import Nimble
import XCApi

class ServiceTests: QuickSpec {
    override func spec() {
        describe("service tests") { 
            it("it xxx  sss") {
                var count: Int = 0

                
                waitUntil(action: { (done) in
                    let producer = Service.fetchCompanyChannelData(params: ["in_id": 22, "page": 0])
                    producer.startWithResult({ (res) in
                        count = res.value!.count
//                        print(count)
//                        print("s88888888888888888888888888888")
                        done()
                    })
                    
                })
                expect(count).toEventually(equal(9))


            }
        }
    }
}
