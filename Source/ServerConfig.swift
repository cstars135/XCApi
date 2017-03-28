//
//  ServerConfig.swift
//  XCApi
//
//  Created by Cstars on 2017/3/20.
//  Copyright © 2017年 cstars. All rights reserved.
//

import Foundation

struct ServerConfig {
    enum ServerType {
        case production, develop
    }
    
    static var baseUrl: URL = URL(string: "http://test.xincheng.tv/xinchengapi/index.php/Api/")!
    static var type: ServerType = .develop {
        didSet {
            if type == .develop {
                ServerConfig.baseUrl = URL(string: "http://test.xincheng.tv/xinchengapi/index.php/Api/")!
            } else {
                ServerConfig.baseUrl = URL(string: "http://test.xincheng.tv/xinchengapi/index.php/Api/")!
            }
        }
    }
}
