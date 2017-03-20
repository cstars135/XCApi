//
//  ServerConfig.swift
//  XCApi
//
//  Created by Cstars on 2017/3/20.
//  Copyright © 2017年 cstars. All rights reserved.
//

import Foundation
protocol ServerConfigType {
    var baseUrl: URL { get }
}
struct ServerConfig: ServerConfigType {
    var baseUrl: URL
}
