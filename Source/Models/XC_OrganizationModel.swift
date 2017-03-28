//
//  XC_OrganizationModel.swift
//  XCBusiness
//
//  Created by Cstars on 2017/1/12.
//  Copyright © 2017年 xincheng.tv. All rights reserved.
//

import Foundation
import SwiftyJSON

struct XC_OrganizationFoldItem: FoldItem {
    let k_id: Int
    let k_cn: String
    let k_en: String
    let kt_id: Int
    let kinfo_one: String
    let kinfo_country: String
    let n_id: Int
    let k_logo: String
    let inId: String
    let inName: String
    let country: String
    
    var news: UnfoldItem?
    //展开时全部分类的数据
    var unfoldItems: [UnfoldSection]?
    
    init(json: JSON) {
        k_id = json["k_id"].intValue
        k_cn = json["k_cn"].stringValue
        k_en = json["k_en"].stringValue
        kt_id = json["kt_id"].intValue
        kinfo_one = json["kinfo_one"].stringValue
        kinfo_country = json["kinfo_country"].stringValue
        n_id = json["n_id"].intValue
        k_logo = json["k_logo"].stringValue
        inId = json["inName", "inId"].stringValue
        inName = json["inName", "inName"].stringValue
        country = json["country"].stringValue
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
        get{
            if !k_en.isEmpty && k_cn != k_en {
                return k_en
            }
            
            return nil
        }
    } //若没有紧挨分割线的标题则为返回nil
    
    var leftBottomTitle: String {
        get{
            return kinfo_country
        }
    }
    public static func formatter(json: JSON) -> [Model] {
        var foldItems = [XC_OrganizationFoldItem]()
        for (_, foldJson):(String, JSON) in  json["data"] {
            
            var foldItem = XC_OrganizationFoldItem(json:foldJson)
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

class XC_OrganizationDataSource: XC_FoldingDataSource{
    func create() -> XC_FoldingDataSource {
        return XC_OrganizationDataSource()
    }
    
    var foldItems: [FoldItem]? = [FoldItem]()
}
