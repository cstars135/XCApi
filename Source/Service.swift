//
//  Service.swift
//  XCApi
//
//  Created by Cstars on 2017/3/24.
//  Copyright © 2017年 cstars. All rights reserved.
//

import Foundation
import SwiftyJSON
import ReactiveSwift
import Alamofire


public protocol Model {
    static func formatter(json: JSON) -> [Model]
}

public struct Service {
    
    public static func fetchProductChannelData(params: [String: Any]) -> SignalProducer<[XC_CompanyFoldModel], FetchDataError> {
        return self.fetchChannelData(url: URL(string: "Company/getList", relativeTo: ServerConfig.baseUrl)!, params: params)
    }
    
    public static func fetchCompanyChannelData(params: [String: Any]) -> SignalProducer<[XC_CompanyFoldModel], FetchDataError> {
        return self.fetchChannelData(url: URL(string: "Company/getList", relativeTo: ServerConfig.baseUrl)!, params: params)
    }
    
    public static func fetchChannelData<M: Model>(url: URL, params: [String: Any]) -> SignalProducer<[M], FetchDataError> {
        let producer = SignalProducer<[M], FetchDataError> { (observer, compositeDisposable) in
            self.requestData(url: url, params: params, result: { (result) in
                switch result {
                case .success(let value):
                    observer.send(value: M.formatter(json: value) as! [M])
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: error as! FetchDataError)
                }
            })
        }
        return producer
    }
    
    public static func requestData(url: URL, params: [String: Any], result: @escaping (Result<JSON>) -> Void) {
        Alamofire.request(url, parameters: params).validate().responseJSON { (response) in
            var res: Result<JSON>
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["errorcode"].intValue != 1000{
                    let error = FetchDataError.serverError(errCode: json["errorcode"].stringValue)
                    res = Result<JSON>.failure(error)
                } else {
                    res = Result.success(json)
                }
            case .failure(let err):
                var error: FetchDataError
                
                if err.localizedDescription == "cancelled" {
                    error = .requestCancelled
                } else {
                    error = .netWorkUnavailable
                }
                res = Result<JSON>.failure(error)
            }
            result(res)
        }
    }
}
