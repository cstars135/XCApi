//
//  ServiceError.swift
//  XCApi
//
//  Created by Cstars on 2017/3/20.
//  Copyright © 2017年 cstars. All rights reserved.
//

import Foundation
//1000	正确。默认值。
//1001	缺少参数
//1002	无此条记录
//1003	已有该记录。比如重复报名
//1004	操作失败，比如报名失败
//1005	请求成功，但内容为空，比如空的列表
//1006	参数值格式错误
//1007	参数值不能为0
//1008	禁止操作

//struct ServerError {
//    var errCode: Int
//    var errMsg: String
//}

public enum FetchDataError: Error {
    case netWorkUnavailable
    case serverError(errCode: String)
    case requestCancelled
    case unknowError
}
