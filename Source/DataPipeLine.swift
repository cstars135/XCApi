////
////  Service.swift
////  XCApi
////
////  Created by Cstars on 2017/3/21.
////  Copyright © 2017年 cstars. All rights reserved.
////
//
//import Foundation
//import ReactiveSwift
//import Alamofire
//import SwiftyJSON
//
//protocol Model {
//    static func formatter(json:JSON) -> [Model]
//}
//
//protocol PipeLineObserver {
//    var beforeAction: (()->Void)? { get }
//    var endAction: ((FetchDataError?)->Void)? { get }
//    var identifier: String { get }
//}
//
//class DataPipeLine {
//    private var url: URL
//    private lazy var observers = [String: PipeLineObserver]()
//    
//    public static var productChannel: DataPipeLine = {
//        return DataPipeLine(url: URL(string: "Product/getList", relativeTo: ServerConfig.baseUrl)!)
//    }()
//    
//    public static var technologyChannel: DataPipeLine = {
//        return DataPipeLine(url: URL(string: "Tech/techList", relativeTo: ServerConfig.baseUrl)!)
//    }()
//    
//    public static var projectChannel: DataPipeLine = {
//        return DataPipeLine(url: URL(string: "Project/proList", relativeTo: ServerConfig.baseUrl)!)
//    }()
//    
//    public static var dataChannel: DataPipeLine = {
//        return DataPipeLine(url: URL(string: "Dates/index", relativeTo: ServerConfig.baseUrl)!)
//    }()
//    
//    public static var companyChannel: DataPipeLine = {
//        return DataPipeLine(url: URL(string: "Company/getList", relativeTo: ServerConfig.baseUrl)!)
//    }()
//    
//    public static var organizerChannel: DataPipeLine = {
//        return DataPipeLine(url: URL(string: "Organize/getList", relativeTo: ServerConfig.baseUrl)!)
//    }()
//    
//    public static var personageChannel: DataPipeLine = {
//        return DataPipeLine(url: URL(string: "people/index", relativeTo: ServerConfig.baseUrl)!)
//    }()
//    
//    public static var investChannel: DataPipeLine = {
//        return DataPipeLine(url: URL(string: "Invest/index", relativeTo: ServerConfig.baseUrl)!)
//    }()
//    
//    init(url: URL) {
//        self.url = url
//    }
//    
//    func subscribe(observer: PipeLineObserver) {
//        self.observers[observer.identifier] = observer
//    }
//    
//    func remove(observer: PipeLineObserver) {
//        self.observers.removeValue(forKey: observer.identifier)
//    }
//    
//    func fetchData<T: Model>(params: [String: Any], before: (()->Void) = {}, end: @escaping ((FetchDataError?)->Void) = {_ in}, flowTo: @escaping ([T])->Void) {
//        before()
//        Alamofire.request(self.url, parameters: params).validate().responseJSON { [weak self](response) in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                if json["errorcode"].intValue != 1000{
//                    let error = FetchDataError.serverError(errCode: json["errorcode"].stringValue)
//                    end(error)
//                } else {
//                    flowTo((self?.formatToM(json: json))! as [T])
//                    end(nil)
//                }
//            case .failure(let err):
//                var error: FetchDataError
//                
//                if err.localizedDescription == "cancelled" {
//                    error = .requestCancelled
//                } else {
//                    error = .netWorkUnavailable
//                }
//                
//                end(error)
//            }
//        }
//    }
//
//    func formatToM<T: Model>(json: JSON) -> [T] {
//        return T.formatter(json: json) as! [T]
//    }
//    
//    func pull<T: Model>(params: [String: Any], flowTo: @escaping ([T]?)->Void) {
//        self.fetchData(params: params,
//        before: {
//            for observer in self.observers.values {
//                if let beforeAction = observer.beforeAction {
//                    beforeAction()
//                }
//            }},
//        end: { (error) in
//            for observer in self.observers.values {
//                if let endAction = observer.endAction {
//                    endAction(error)
//                }
//            }},
//        flowTo: { (models) in
//            flowTo(models)
//        })
//    }
//}
