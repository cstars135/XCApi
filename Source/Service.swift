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


public class PipeLine<T: Model> {
    public var url: URL
    private var page = 0
    
    public init(url: URL) {
        self.url = url
    }
    
    public func fetchData(in_id: Int) -> SignalProducer<[T], FetchDataError> {
        return self.fetchChannelData(url: url, params: ["in_id": in_id]).on(completed: { [weak self] in
            self!.page = 1
        })
    }
    
    public func fetchNext(in_id: Int) -> SignalProducer<[T], FetchDataError> {
        return self.fetchChannelData(url: url, params: ["in_id": in_id, "page": page]).on( completed: { [weak self] in
            self!.page += 1
        })
    }
    
    public func fetchChannelData<M: Model>(url: URL, params: [String: Any]) -> SignalProducer<[M], FetchDataError> {
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
    
    public func requestData(url: URL, params: [String: Any], result: @escaping (Result<JSON>) -> Void) {
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

public struct Service {
    public static var productChannelStream = PipeLine<XC_ProductFoldItem>(url: URL(string: "Product/getList", relativeTo: ServerConfig.baseUrl)!)
    
    public static var TechChannelStream = PipeLine<XC_TechnologyFoldItem>(url: URL(string: "Tech/techList", relativeTo: ServerConfig.baseUrl)!)

    public static var projectChannelStream = PipeLine<XC_ProjectFoldItem>(url: URL(string: "Project/proList", relativeTo: ServerConfig.baseUrl)!)
    
    public static var dataChannelStream = PipeLine<XC_DataChannelFormatterItem>(url: URL(string: "Dates/index", relativeTo: ServerConfig.baseUrl)!)

    public static var companyChannelStream = PipeLine<XC_CompanyFoldModel>(url: URL(string: "Company/getList", relativeTo: ServerConfig.baseUrl)!)
    
    public static var organizationChannelStream = PipeLine<XC_OrganizationFoldItem>(url: URL(string: "Organize/getList", relativeTo: ServerConfig.baseUrl)!)

    public static var personageChannelStream = PipeLine<XC_PersonageFoldItem>(url: URL(string: "people/index", relativeTo: ServerConfig.baseUrl)!)
    
    public static var investChannelStream = PipeLine<XC_InvestChannelModel>(url: URL(string: "Invest/index", relativeTo: ServerConfig.baseUrl)!)
}
