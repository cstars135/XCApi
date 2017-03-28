//
//  XC_ProjectModel.swift
//  XC_ProjectModel
//
//  Created by QIU on 2017/1/4.
//  Copyright © 2017年 cstars. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreGraphics

public struct XC_ProjectFoldItem: FoldItem {
    
    let pj_id: Int
    let pj_cn: String
    let pj_en: String
    let n_id: Int
    let kpj_id: Int
    let pj_logo: String
    let pj_order: Int
    let pjin_id: Int

    let keyName: String
    let inId: String
    let inName: String
    
    public var news: UnfoldItem?
    //展开时全部分类的数据
    public var unfoldItems: [UnfoldSection]?
    public init(json: JSON) {
        pj_id = json["pj_id"].intValue
        pj_cn = json["pj_cn"].stringValue
        pj_en = json["pj_en"].stringValue
        kpj_id = json["k_id"].intValue
        n_id = json["n_id"].intValue
        pj_logo = json["pj_logo"].stringValue
        pj_order = json["pj_order"].intValue
        pjin_id = json["in_id"].intValue
        keyName = json["keyName"].stringValue
        inId = json["inName", "inId"].stringValue
        inName = json["inName", "inName"].stringValue
    }
    
    //Mark: - view model
    public var iconUrl: URL? {
        return URL(string: pj_logo)
    }
    
    public var leftFirstTitle: String {
        get {
            return inName.with(placeholder: placeholderStr)
        }
    }
    
    
    public var leftSecondTitle: String {
        
        get{
            if !pj_cn.isEmpty && !pj_en.isEmpty {
                return pj_cn == pj_en ? pj_cn : (pj_cn + ": " + pj_en)
            } else if !pj_cn.isEmpty {
                return pj_cn
            } else if !pj_en.isEmpty {
                return pj_en
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
        var foldItems = [XC_ProjectFoldItem]()
        for (_, foldJson):(String, JSON) in  json["data"] {
            
            var foldItem = XC_ProjectFoldItem(json:foldJson)
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


public class XC_ProjectDataSource: XC_FoldingDataSource{
    func create() -> XC_FoldingDataSource {
        return XC_ProjectDataSource()
    }
    
    public var foldItems: [FoldItem]? = []

}
