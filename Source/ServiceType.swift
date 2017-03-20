//
//  ServiceType.swift
//  XCApi
//
//  Created by Cstars on 2017/3/20.
//  Copyright © 2017年 cstars. All rights reserved.
//

import Foundation
import ReactiveSwift

/**
 A type that knows how to perform requests for XCBusiness data.
 */
protocol ServiceType {
    var serverConfig: ServerConfigType { get }
    init(serverConfig: ServerConfigType)
    
    func fetchProducts(params: ChannelParams) -> SignalProducer<>
    
}
