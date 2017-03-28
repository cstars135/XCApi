//
//  UnfoldModels.swift
//  XCApi
//
//  Created by Cstars on 2017/3/22.
//  Copyright © 2017年 cstars. All rights reserved.
//

import Foundation
import SwiftyJSON

//MARK: - News
struct XC_NewsUnflodItem: UnfoldItem {
    let n_id: Int
    let n_title1: String
    let n_title2: String
    let n_logo: String
    let in_id: Int
    let newsCon: String
    let inId: String
    let inName: String
    var indexPath: IndexPath?
    
    init(json: JSON) {
        n_id = json["n_id"].intValue
        n_title1 = json["n_title1"].stringValue
        n_title2 = json["n_title2"].stringValue
        n_logo = json["n_logo"].stringValue
        newsCon = json["newsCon"].stringValue
        in_id = json["in_id"].intValue
        inId = json["inName", "inId"].stringValue
        inName = json["inName", "inName"].stringValue
    }
    
    //Mark: - view model
    var iconUrl: URL? {
        return URL(string: n_logo)
    }
    
    var firstTitle: String {
        return inName.with(placeholder: placeholderStr)
    }
    
    var secondTitle: String {
        return n_title1.with(placeholder: placeholderStr)
    }
    
    var detailDescribe: String {
        return newsCon.with(placeholder: placeholderStr)
    }
    
}

//MARK: - Tech
struct XC_TechUnflodItem: UnfoldItem {
    let t_id: Int
    let t_cn: String
    let t_en: String
    let t_logo: String
    let in_id: Int
    let newsCon: String
    let inId: String
    let inName: String
    let n_id: Int
    var indexPath: IndexPath?
    
    init(json: JSON) {
        t_id = json["t_id"].intValue
        t_cn = json["t_cn"].stringValue
        t_en = json["t_en"].stringValue
        t_logo = json["t_logo"].stringValue
        newsCon = json["newsCon"].stringValue
        in_id = json["in_id"].intValue
        inId = json["inName", "inId"].stringValue
        inName = json["inName", "inName"].stringValue
        n_id = json["n_id"].intValue
    }
    
    //Mark: - view model
    var iconUrl: URL? {
        return URL(string: t_logo)
    }
    
    var firstTitle: String {
        return  inName.with(placeholder: placeholderStr)
    }
    
    var secondTitle: String {
        if t_cn.isEmpty {
            return t_en.with(placeholder: placeholderStr)
        }
        if t_en.isEmpty {
            return t_cn.with(placeholder: placeholderStr)
        }
        return t_cn + ": " + t_en
    }
    
    var detailDescribe: String {
        return newsCon.with(placeholder: placeholderStr)
    }
}

//MARK: - Product
struct XC_ProductUnflodItem: UnfoldItem {
    let p_id: Int
    let p_cn: String
    let p_en: String
    let p_logo: String
    let in_id: Int
    let newsCon: String
    let inId: String
    let inName: String
    let n_id: Int
    var indexPath: IndexPath?
    
    init(json: JSON) {
        p_id = json["p_id"].intValue
        p_cn = json["p_cn"].stringValue
        p_en = json["p_en"].stringValue
        p_logo = json["p_logo"].stringValue
        newsCon = json["newsCon"].stringValue
        in_id = json["in_id"].intValue
        inId = json["inName", "inId"].stringValue
        inName = json["inName", "inName"].stringValue
        n_id = json["n_id"].intValue
    }
    
    //Mark: - view model
    var iconUrl: URL? {
        return URL(string: p_logo)
    }
    
    var firstTitle: String {
        return  inName.with(placeholder: placeholderStr)
    }
    
    var secondTitle: String {
        if p_cn.isEmpty {
            return p_en.with(placeholder: placeholderStr)
        }
        if p_en.isEmpty {
            return p_cn.with(placeholder: placeholderStr)
        }
        return p_cn + ": " + p_en
    }
    
    var detailDescribe: String {
        return newsCon.with(placeholder: placeholderStr)
    }
}

//MARK: - Project
struct XC_ProjectUnflodItem: UnfoldItem {
    let pj_id: Int
    let pj_cn: String
    let pj_en: String
    let pj_logo: String
    let in_id: Int
    let newsCon: String
    let inId: String
    let inName: String
    let n_id: Int
    var indexPath: IndexPath?
    
    init(json: JSON) {
        pj_id = json["pj_id"].intValue
        pj_cn = json["pj_cn"].stringValue
        pj_en = json["pj_en"].stringValue
        pj_logo = json["pj_logo"].stringValue
        newsCon = json["newsCon"].stringValue
        in_id = json["in_id"].intValue
        inId = json["inName", "inId"].stringValue
        inName = json["inName", "inName"].stringValue
        n_id = json["n_id"].intValue
    }
    
    //Mark: - view model
    var iconUrl: URL? {
        return URL(string: pj_logo)
    }
    
    var firstTitle: String {
        return  inName.with(placeholder: placeholderStr)
    }
    
    var secondTitle: String {
        if pj_cn.isEmpty {
            return pj_en.with(placeholder: placeholderStr)
        }
        if pj_en.isEmpty {
            return pj_cn.with(placeholder: placeholderStr)
        }
        return pj_cn + ": " + pj_en
    }
    
    var detailDescribe: String {
        return newsCon.with(placeholder: placeholderStr)
    }
}

//MARK: - Keyman
struct XC_KeymanUnflodItem: UnfoldItem {
    let k_id: Int
    let k_cn: String
    let k_en: String
    let kt_id: Int
    let kinfo_one: String
    let kinfo_country: String
    let n_id: Int
    let k_logo: String
    let post: String
    var indexPath: IndexPath?
    
    init(json: JSON) {
        k_id = json["k_id"].intValue
        k_cn = json["k_cn"].stringValue
        k_en = json["k_en"].stringValue
        kt_id = json["kt_id"].intValue
        kinfo_one = json["kinfo_one"].stringValue
        kinfo_country = json["kinfo_country"].stringValue
        n_id = json["n_id"].intValue
        k_logo = json["k_logo"].stringValue
        post = json["post"].stringValue
    }
    //Mark: - view model
    var iconUrl: URL? {
        return URL(string: k_logo)
    }
    
    var firstTitle: String {
        return  kinfo_one.with(placeholder: placeholderStr)
    }
    
    var secondTitle: String {
        if k_cn.isEmpty {
            return k_en.with(placeholder: placeholderStr)
        }
        if k_en.isEmpty {
            return k_cn.with(placeholder: placeholderStr)
        }
        return k_cn + ": " + k_en
    }
    
    var detailDescribe: String {
        return post.with(placeholder: placeholderStr)
    }
}

//MARK: - SubCompany
struct XC_SubCompanyUnflodItem: UnfoldItem {
    //    "k_id": "48",
    //    "k_cn": "Emotient",
    //    "k_en": "Emotient",
    //    "kt_id": "10",
    //    "kinfo_one": "情绪识别软件公司",
    //    "kinfo_country": "6",
    //    "n_id": "15",
    //    "k_logo": "http://pic.xincheng.tv/xincheng/2016/1112/6bad4092d7bbfcafdd59477a.jpg",
    //    "newsCon": ""
    let k_id: Int
    let k_cn: String
    let k_en: String
    let kt_id: Int
    let kinfo_one: String
    let kinfo_country: String
    let n_id: Int
    let k_logo: String
    let newsCon: String
    var indexPath: IndexPath?
    
    init(json: JSON) {
        k_id = json["k_id"].intValue
        k_cn = json["k_cn"].stringValue
        k_en = json["k_en"].stringValue
        kt_id = json["kinfo_one"].intValue
        kinfo_one = json["kt_id"].stringValue
        kinfo_country = json["kinfo_country"].stringValue
        n_id = json["n_id"].intValue
        k_logo = json["k_logo"].stringValue
        newsCon = json["newsCon"].stringValue
    }
    
    //Mark: - view model
    var iconUrl: URL? {
        return URL(string: k_logo)
    }
    
    var firstTitle: String {
        return  kinfo_one
    }
    
    var secondTitle: String {
        return k_cn + ": " + k_en
    }
    
    var detailDescribe: String {
        return kinfo_country
    }
}
