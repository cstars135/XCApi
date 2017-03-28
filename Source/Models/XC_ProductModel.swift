//
//  XC_FoldModel.swift
//  XCBusiness
//
//  Created by Cstars on 2017/1/11.
//  Copyright © 2017年 xincheng.tv. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreGraphics

struct XC_ProductFoldItem: FoldItem {
    let p_id: Int
    let p_cn: String
    let p_en: String
    let k_id: Int
    let in_id: Int
    let n_id: Int
    let p_logo: String
    let keyCnname: String
    let keyEnname: String
    var techCount: Int
    var keyCount: Int
    let inId: String
    let inName: String
    var news: UnfoldItem?
    //展开时全部分类的数据
    var unfoldItems: [UnfoldSection]?
    
    init(json: JSON) {
        p_id = json["p_id"].intValue
        p_cn = json["p_cn"].stringValue
        p_en = json["p_en"].stringValue
        k_id = json["k_id"].intValue
        in_id = json["in_id"].intValue
        n_id = json["n_id"].intValue
        p_logo = json["p_logo"].stringValue
        keyCnname = json["keyCnname"].stringValue
        keyEnname = json["keyEnname"].stringValue
        techCount = json["techCount"].intValue
        keyCount = json["keyCount"].intValue
        inId = json["inName", "inId"].stringValue
        inName = json["inName", "inName"].stringValue
    }
    
    //Mark: - view model
    var iconUrl: URL? {
        return URL(string: p_logo)
    }
    
    var leftFirstTitle: String {
        get {
            return inName.with(placeholder: placeholderStr)
        }
    }
    var leftSecondTitle: String {
        get {
            if !p_cn.isEmpty && !p_en.isEmpty {
                return p_cn == p_en ? p_cn : p_cn + ": " + p_en
            } else if !p_cn.isEmpty {
                return p_cn
            } else if !p_en.isEmpty {
                return p_en
            } else {
                return placeholderStr
            }
        }
    }
    
    var leftLineTopTitle: String? = nil
    
    var leftBottomTitle: String {
        get {
            
            if !keyCnname.isEmpty && !keyEnname.isEmpty {
                return keyCnname == keyEnname ? keyCnname : keyCnname + " " + keyEnname
            } else if !keyCnname.isEmpty {
                return keyCnname
            } else if !keyEnname.isEmpty {
                return keyEnname
            } else {
                return placeholderStr
            }
        }
    }
    
    public static func formatter(json: JSON) -> [Model] {
        var foldItems = [XC_ProductFoldItem]()
        for (_, foldJson):(String, JSON) in  json["data"] {
            
            var foldItem = XC_ProductFoldItem(json:foldJson)
            //news
            if let newsJson = foldJson["list", "news"].arrayValue.first {
                foldItem.news = XC_NewsUnflodItem(json: newsJson)
            }
            
            var techArr = [UnfoldItem](), productArr = [UnfoldItem](), projectArr = [UnfoldItem](), keywordsArr = [UnfoldItem]()
            var unfoldItems = [UnfoldSection]()
            
            //tech
            for (_, techJson):(String, JSON) in foldJson["list", "tech"]{
                let techModel = XC_TechUnflodItem(json: techJson)
                techArr.append(techModel)
            }
            
            if !techArr.isEmpty {
                unfoldItems.append(UnfoldSection(title: "科技", items: techArr))
            }
            
            //product
            for (_, productJson):(String, JSON) in foldJson["list", "product"]{
                let productModel = XC_ProductUnflodItem(json: productJson)
                productArr.append(productModel)
            }
            
            if !productArr.isEmpty {
                unfoldItems.append(UnfoldSection(title: "产品", items: productArr))
            }
            
            //project
            for (_, projectJson):(String, JSON) in foldJson["list", "project"]{
                let projectModel = XC_ProjectUnflodItem(json: projectJson)
                projectArr.append(projectModel)
            }
            
            if !projectArr.isEmpty {
                unfoldItems.append(UnfoldSection(title: "项目", items: projectArr))
            }
            
            
            //keywords
            for (_, keywordsJson):(String, JSON) in foldJson["list", "keywords"]{
                let keywordsModel = XC_KeymanUnflodItem(json: keywordsJson)
                keywordsArr.append(keywordsModel)
            }
            
            if !keywordsArr.isEmpty {
                unfoldItems.append(UnfoldSection(title: "关键人物", items: keywordsArr))
            }
            
            foldItem.unfoldItems = unfoldItems
            foldItems.append(foldItem)
        }
        return foldItems
    }
}

class XC_ProductDataSource: XC_FoldingDataSource{
    func create() -> XC_FoldingDataSource {
        return XC_ProductDataSource()
    }
    
    var foldItems: [FoldItem]? = []
}

