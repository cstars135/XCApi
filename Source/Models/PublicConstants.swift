//
//  PublicConstants.swift
//  CompanyModule
//
//  Created by Cstars on 2016/12/26.
//  Copyright © 2016年 cstars. All rights reserved.
//
//全局共享代码
import Foundation
import UIKit
//color
//let bgColor = colorFromRGB(hex: 0xE3E3E3)




//distance
let screenW = UIScreen.main.bounds.size.width
let screenH = UIScreen.main.bounds.size.height

//scale
let screenScale = UIScreen.main.scale

///-------------网络接口------------------------------
let BASE_URL = "http://test.xincheng.tv/xinchengapi/index.php/Api/"
//首页
//let indexURL = BASE_URL + "Index/index"



let placeholderStr = "数据缺失"


//新闻详情
//let XC_NEWS_SIDE_PADDING = CGFloat(11).xc_lengthScale()
let XC_NEWS_Font_SIZE_4S = CGFloat(10)
let XC_NEWS_MARGIN_4S = CGFloat(10)
let XC_NEWS_CONTENT_FONT = xc_newsContentTextFont()
let XC_NEWS_TEXT_LINE_SPACE: CGFloat = 3

let XC_NEWS_RIGHT_LIST_W: CGFloat = {
    switch XC_DEVICE_TYPE {
    case .series_4, .series_5:
        return 128
    case .series_6:
        return 150
    case .series_6_plus:
        return 166
    default:
        break
    }
    return 0
}()

//设备类型
let XC_DEVICE_TYPE = xc_deviceType()

//App顶部导航栏高度
let XC_TOP_NAV_H: CGFloat = {
    switch XC_DEVICE_TYPE {
    case .series_4, .series_5:
        return 38
    case .series_6:
        return 45
    case .series_6_plus:
        return 50
    default:
        break
    }
    return 0
}()

//频道文本颜色
//浅色
//let CHANNEL_TEXT_COLOR_LIGHT = colorFromRGB(hex: 0x4A4A4A)


//极小正数
let MIN_POSITIVE_NUM =  CGFloat(0.0000001)



