//
//  InvestChannelModel.swift
//  CompanyModule
//
//  Created by Cstars on 2016/12/30.
//  Copyright © 2016年 cstars. All rights reserved.
//

import Foundation
import SwiftyJSON

public class XC_InvestChannelDataSource {
    var data = [InvestChannelModel]()
    
    func removeAll() {
        data.removeAll()
    }
    
    func append(items: [Any]) {
        self.data.append(contentsOf: items as! [InvestChannelModel])
    }
}

public class InvestChannelModel {
    public var company: Company?
    public var investors = [Investor]()
    
    public struct Company {
        let sum: String
        let i_id: Int
        let unit1: String
        let unit2: String
        let phase: String
        let k_cn: String
        let k_en: String
        let kinfo_one: String
        let k_logo: String
        let country: String
        let state: String
        let city: String
        
        init(json: JSON) {
            sum = json["sum"].stringValue
            i_id = json["i_id"].intValue
            unit1 = json["unit1"].stringValue
            unit2 = json["unit2"].stringValue
            phase = json["phase"].stringValue
            country = json["country"].stringValue
            state = json["state"].stringValue
            city = json["city"].stringValue
            
            k_cn = json["info", "k_cn"].stringValue
            k_en = json["info", "k_en"].stringValue
            kinfo_one = json["info", "kinfo_one"].stringValue
            k_logo = json["info", "k_logo"].stringValue
            
        }
        
        //MARK: - VIEW MODEL
        var iconUrl: URL? {
            return URL(string: k_logo)
        }
        
        var leftFirstTitle: String {
            return kinfo_one
        }
        
        var leftSecondTitle: String {
            return k_cn
        }
        
        func leftTitles(index: Int) -> String {
            switch index {
            case 0:
                return kinfo_one
            case 1:
                if !k_cn.isEmpty {
                    return k_cn
                } else {
                    if !k_en.isEmpty {
                        return k_en
                    } else {
                        return ""
                    }
                }
            case 2:
                if k_cn != k_en && (!k_cn.isEmpty) {
                    return k_en
                } else {
                    return ""
                }
            case 3:
                return country + state + city
            default:
                return ""
            }
        }
        
        func rightTitles(index: Int) -> String {
            switch index {
            case 0:
                return phase
            case 1:
                return sum + unit2 + unit1
            default:
                return ""
            }
        }
    }

    public struct Investor {
        let phase: String
        let sum: String
        let unit1: String
        let unit2: String
        let k_cn: String
        let k_en: String
        
        init(json: JSON) {
            phase = json["phase"].stringValue
            sum = json["sum"].stringValue
            unit1 = json["unit1"].stringValue
            unit2 = json["unit2"].stringValue
            k_cn = json["k_cn"].stringValue
            k_en = json["k_en"].stringValue  
        }
        
        //MARK: - VIEW MODEL
        var firstTitle: String {
            return k_cn
        }
        
        var secondTitle: String {
            if k_cn == k_en {
                return ""
            }
            return k_en
        }
        
        var thirdTitle: String {
            if sum.isEmpty || phase.isEmpty {
                return "未知"
            }
            return "投资: " + sum + unit2 + unit1 + ", 占股" + phase
        }
    }
}







