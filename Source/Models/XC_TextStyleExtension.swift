//
//  XC_TextStyleExtension.swift
//  CompanyModule
//
//  Created by Cstars on 2016/12/20.
//  Copyright © 2016年 cstars. All rights reserved.
//

import Foundation
import UIKit

let ULTRA_LIGHT = "PingFangSC-Ultralight"
let THIN = "PingFangSC-Thin"
let Light = "PingFangSC-Light"
let MEDIUM = "PingFangSC-Medium"
let REGULAR = "PingFangSC-Regular"
let SEMIBOLD = "PingFangSC-Semibold"

func colorFromRGB(r: UInt, g: UInt, b: UInt) -> UIColor {
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
}

func colorFromRGB(hex: UInt) -> UIColor {
    let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    let g = CGFloat((hex & 0xFF00) >> 8 ) / 255.0
    let b = CGFloat(hex & 0xFF) / 255.0
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
}

func colorFromRGBA(hex: UInt, alpha: CGFloat) -> UIColor {
    let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    let g = CGFloat((hex & 0xFF00) >> 8 ) / 255.0
    let b = CGFloat(hex & 0xFF) / 255.0
    return UIColor(red: r, green: g, blue: b, alpha: alpha)
}


func textStyle(flag: String) -> (UIFont, UIColor) {
    switch flag {
    case "f136":
        return (UIFont(name: SEMIBOLD, size: 36 * 0.6)!, colorFromRGB(hex: 0x9B9B9B))
    case "f236":
        return (UIFont(name: SEMIBOLD, size: 36 * 0.6)!, colorFromRGB(hex: 0x1A96FD))
        
    case "f130":
        return (UIFont(name: SEMIBOLD, size: 30 * 0.6)!, colorFromRGB(hex: 0x9B9B9B))
    case "f230":
        return (UIFont(name: SEMIBOLD, size: 30 * 0.6)!, colorFromRGB(hex: 0x1A96FD))
        
    case "f124":
        return (UIFont(name: SEMIBOLD, size: 24 * 0.6)!, colorFromRGB(hex: 0x000000))
    case "f224":
        return (UIFont(name: SEMIBOLD, size: 24 * 0.6)!, colorFromRGB(hex: 0x1A96FD))
        
    case "f120":
        return (UIFont(name: SEMIBOLD, size: 20 * 0.6)!, colorFromRGB(hex: 0x9B9B9B))
    case "f220":
        return (UIFont(name: SEMIBOLD, size: 20 * 0.6)!, colorFromRGB(hex: 0x000000))
        
    case "f118":
        return (UIFont(name: REGULAR, size: 18 * 0.6)!, colorFromRGB(hex: 0x9B9B9B))
    case "f218":
        return (UIFont(name: REGULAR, size: 18 * 0.6)!, colorFromRGB(hex: 0x1A96FD))
        
    default:
        return (UIFont.systemFont(ofSize: 13.0), UIColor.black)
    }
}


extension UILabel {
    func configTextStyle(flag: String) {
        let (font, color) = textStyle(flag: flag)
        self.font = font
        self.textColor = color
    }
    
    func configTextStyleForHightlight(flag: String) {
        let (font, color) = textStyle(flag: flag)
        self.font = font
        self.highlightedTextColor = color
    }
}

extension UITextField {
    func configTextStyle(flag: String) {
        let (font, color) = textStyle(flag: flag)
        self.font = font
        self.textColor = color
    }
}

extension UITextView {
    func configTextStyle(flag: String) {
        let (font, color) = textStyle(flag: flag)
        self.font = font
        self.textColor = color
    }
}

extension UIColor {
    func L140() -> UIColor {
        return colorFromRGB(hex: 0x9B9B9B)
    }
    
    func L240() -> UIColor {
        return UIColor.black
    }
}



