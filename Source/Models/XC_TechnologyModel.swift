//
//  XC_TechnologyModel.swift
//  XC_TechnologyModel
//
//  Created by QIU on 2017/1/4.
//  Copyright © 2017年 cstars. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreGraphics

public struct XC_TechnologyFoldItem: FoldItem {
    let t_id: Int
    let t_cn: String
    let t_en: String
    let n_id: Int
    let k_id: Int
    let t_logo: String
    let in_id: Int
    let keyName: String
    let inId: String
    let inName: String
    
    public var news: UnfoldItem?
    //展开时全部分类的数据
    public var unfoldItems: [UnfoldSection]?
    
    public init(json: JSON) {
        t_id = json["t_id"].intValue
        t_cn = json["t_cn"].stringValue
        t_en = json["t_en"].stringValue
        k_id = json["k_id"].intValue
        n_id = json["n_id"].intValue
        t_logo = json["t_logo"].stringValue
        in_id = json["in_id"].intValue
        keyName = json["keyName"].stringValue
        inId = json["inName", "inId"].stringValue
        inName = json["inName", "inName"].stringValue
    }
    
    //Mark: - view model
    public var iconUrl: URL? {
        return URL(string: t_logo)
    }
    
    public var leftFirstTitle: String {
        get {
            return inName.with(placeholder: placeholderStr)
        }
    }
    public var leftSecondTitle: String {
        get{
            if !t_cn.isEmpty && !t_en.isEmpty {
                return t_cn == t_en ? t_cn : (t_cn + ": " + t_en)
            } else if !t_cn.isEmpty {
                return t_cn
            } else if !t_en.isEmpty {
                return t_en
            } else {
                return placeholderStr
            }
        }
    }
    
    public var leftLineTopTitle: String? = nil
    
    public var leftBottomTitle: String {
        get{
            return  keyName.with(placeholder: placeholderStr)
        }
    }
    
    public static func formatter(json: JSON) -> [Model] {
        var foldItems = [XC_TechnologyFoldItem]()
        for (_, foldJson):(String, JSON) in  json["data"] {
            
            var foldItem = XC_TechnologyFoldItem(json:foldJson)
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


public class XC_TechnologyDataSource: XC_FoldingDataSource{
    func create() -> XC_FoldingDataSource {
        return XC_TechnologyDataSource()
    }
    
    public var foldItems: [FoldItem]? = []

    
}
