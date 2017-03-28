//
//  UtiliFuncs.swift
//  CompanyModule
//
//  Created by Cstars on 2017/1/3.
//  Copyright © 2017年 cstars. All rights reserved.
//

import Foundation
func delay(time: TimeInterval, op: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: op)
}

enum XC_DeviceType {
    case series_4, series_5, series_6, series_6_plus, series_unknown
}

func xc_deviceType() -> XC_DeviceType {
    let maxLengthSide = screenW > screenH ? screenW : screenH
    switch maxLengthSide {
    case 480:
        return .series_4
    case 568:
        return .series_5
    case 667:
        return .series_6
    case 736:
        return .series_6_plus
    default:
        return .series_unknown
    }
}

func xc_newsContentTextFont() -> UIFont {
    var textFont: UIFont = UIFont(name: REGULAR, size: 12)!
    switch XC_DEVICE_TYPE {
    case .series_6:
        textFont = UIFont(name: REGULAR, size: 13)!
        break
    case .series_6_plus:
        textFont = UIFont(name: REGULAR, size: 13)!
    default:
        break
    }
    return textFont
}

