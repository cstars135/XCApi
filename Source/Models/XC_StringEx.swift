//
//  XC_StringEx.swift
//  XCBusiness
//
//  Created by Cstars on 2017/1/17.
//  Copyright © 2017年 xincheng.tv. All rights reserved.
//

import Foundation

extension String {
    func height(attributes:[String: Any], size: CGSize) -> CGFloat{
        let targetStr = self as NSString
        let resSize = targetStr.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return ceil(resSize.height)
    }
}

extension String {
    func with( placeholder: String) -> String {
        return self.isEmpty ? placeholder : self
    }
    
    //时间戳转换到日期
    func dateStr() -> String {
        guard let timeInterval = TimeInterval(self) else {
            return ""
        }
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
}

/**
 字符串去除前后的空白字符
 */
fileprivate let whitespaceAndNewlineChars: [Character] = ["\n", "\r", "\t", " ","\r\n"]
extension String {
    func ltrim() -> String {
        if isEmpty { return "" }
        var i = startIndex
        
        for c in self.characters {
            if whitespaceAndNewlineChars.contains(c) {
                if self[i..<endIndex].characters.count > 0 {
                    i = self.index(after: i)
                } else {
                    break
                }
                continue
            }
            break
        }
        return self[i..<endIndex]
    }
    
    func rtrim() -> String {
        if isEmpty { return "" }
        var i = endIndex
        
        for c in self.characters.makeIterator().reversed() {
            if whitespaceAndNewlineChars.contains(c) {
                i = self.index(before: i)
                continue
            }
            break
        }
        return self[startIndex..<i]
    }
    
    func trim() -> String {
        return ltrim().rtrim()
    }
}
