//
//  XC_PersonageModel.swift
//  XCBusiness
//
//  Created by Cstars on 2017/1/13.
//  Copyright © 2017年 xincheng.tv. All rights reserved.
//

import Foundation
import SwiftyJSON

struct XC_PersonageFoldItem: FoldItem {
    let k_id: Int
    let k_cn: String
    let k_en: String
    let kinfo_one: String
    let kinfo_country: String
    let info_birth: String
    let k_logo: String
    let company: String
    let business: String
    let in_id: Int
    
    var news: UnfoldItem?
    var unfoldItems: [UnfoldSection]?
    
    init(json: JSON) {
        k_id = json["k_id"].intValue
        k_cn = json["k_cn"].stringValue
        k_en = json["k_en"].stringValue
        kinfo_one = json["kinfo_one"].stringValue
        kinfo_country = json["kinfo_country"].stringValue
        info_birth = json["info_birth"].stringValue
        k_logo = json["k_logo"].stringValue
        company = json["company"].stringValue
        business = json["business"].stringValue
        in_id = json["in_id"].intValue
    }
    
    //Mark: - view model
    var iconUrl: URL? {
        return URL(string: k_logo)
    }
    
    var leftFirstTitle: String {
        get {
            return kinfo_one.with(placeholder: placeholderStr)
        }
    }
    var leftSecondTitle: String {
        get{
            if !k_cn.isEmpty {
                return k_cn
            } else if !k_en.isEmpty {
                return k_en
            } else{
                return placeholderStr
            }
        }
    }
    
    var leftLineTopTitle: String? {
        get {
            if !k_en.isEmpty && k_cn != k_en {
                return k_en
            }
            return nil
        }
    } //若没有紧挨分割线的标题则为返回nil
    
    var leftBottomTitle: String {
        get{
            let post = (company + business).isEmpty ? placeholderStr : (company.isEmpty ? business : company + business)
            return post + " (来自: " + kinfo_country.with(placeholder: placeholderStr) + ")"
        }
    }
    
    public static func formatter(json: JSON) -> [Model] {
        var foldItems = [XC_PersonageFoldItem]()
        for (_, foldJson):(String, JSON) in  json["data"] {
            
            var foldItem = XC_PersonageFoldItem(json:foldJson)
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

class XC_PersonageDataSource: XC_FoldingDataSource{
    func create() -> XC_FoldingDataSource {
        return XC_PersonageDataSource()
    }
    
    var foldItems: [FoldItem]? = [FoldItem]()
}
