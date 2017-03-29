//
//  DataChannelModel.swift
//  CompanyModule
//
//  Created by Cstars on 2016/12/26.
//  Copyright © 2016年 cstars. All rights reserved.
//

import Foundation
import SwiftyJSON

private let NAME_COL_W: CGFloat = 140
let XC_DATA_ICON_H: CGFloat = 23

extension Array {
    func combine<T>(target: [T]) -> [(Array.Element, T)] {
        let count = (self.count < target.count) ? self.count : target.count
        var temp: [(Array.Element, T)] = []
        temp.reserveCapacity(count)
        for i in 0..<count {
            temp.append((self[i], target[i]))
        }
        return temp
    }
}

public protocol XC_DataChannelItemType: Model {
    var dataType: XC_DataChannelDataSource.DataStyle { get }
    var type: Int { get }
    
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func mainTitle() -> String
    func subTitle() -> String
}

public extension XC_DataChannelItemType {
    public var dataType: XC_DataChannelDataSource.DataStyle {
        return XC_DataChannelDataSource.dataType(type: self.type)
    }
}


public class XC_DataChannelFormatterItem: Model {
    public static func formatter(json: JSON) -> [Model] {
        var items = [Any]()
        for (_, subjson): (String, JSON) in json["data"] {
            let type = XC_DataChannelDataSource.dataType(type: subjson["type"].intValue)
            var item: XC_DataChannelItemType
            switch type {
            case .basic:
                item = XC_DataChannelDataSource.DataBasicModel(json: subjson)
            case .singleGroup:
                item = XC_DataChannelDataSource.DataSingleGroupModel(json: subjson)
            case .mutiGroup:
                item = XC_DataChannelDataSource.DataMutiGroupModel(json: subjson)
            }
            items.append(item)
        }
        return items as! [Model]
    }
}


public class XC_DataChannelDataSource {
    public var data = [XC_DataChannelItemType]()
    
    public func removeAll() {
        self.data.removeAll()
    }
    
    public func append(items: [Any]) {
        self.data.append(contentsOf: items as! [XC_DataChannelItemType])
    }
    
    public enum DataStyle {
        case basic, singleGroup, mutiGroup
    }
    
    public static func dataType(type: Int) -> DataStyle {
        if type == 14 {
            return .basic
        } else if type == 15 {
            return .singleGroup
        } else {
            return .mutiGroup
        }
    }
    
    
    class DataBasicModel: XC_DataChannelFormatterItem, XC_DataChannelItemType {
        let type: Int
        let k_cn: String
        let k_en: String
        let k_logo: String
        let kinfo_one: String
        let dg_wh: String
        let name: String
        let dgn_num: String
        let cl_id: String
        let cl_id2: String
        let time: String
        init(json: JSON) {
            type = json["type"].intValue
            k_cn = json["info", "k_cn"].stringValue
            k_en = json["info" ,"k_en"].stringValue
            k_logo = json["info", "k_logo"].stringValue
            kinfo_one = json["info", "kinfo_one"].stringValue
            dg_wh = json["dg_wh"].stringValue
            name = json["name"].stringValue
            dgn_num = json["dgn_num"].stringValue
            cl_id = json["cl_id"].stringValue
            cl_id2 = json["cl_id2"].stringValue
            time = json["a", "time"].stringValue
        }
        
        //MARK: - View Model
        var iconUrl: URL? {
            return URL(string: k_logo)
        }
        
        func leftTitles() ->[String] {
            let firstTitle = kinfo_one.with(placeholder: placeholderStr)
            var secondTitle: String
            if !k_cn.isEmpty {
                secondTitle = k_cn
            } else {
                secondTitle = k_en
            }
            secondTitle = secondTitle.with(placeholder: placeholderStr)
            let thirdTitle = dg_wh.with(placeholder: placeholderStr)
            let fourTitle = time.with(placeholder: placeholderStr)
            return [firstTitle, secondTitle, thirdTitle, fourTitle]
        }
        
        func rightTitles() ->[String] {
            return [name.with(placeholder: placeholderStr), (dgn_num + cl_id + cl_id2).with(placeholder: placeholderStr)]
        }
        
        func numberOfRows() -> Int {
            return 1
        }
        
        func numberOfSections() -> Int {
            return 1
        }
        
        func mainTitle() -> String {
            return ""
        }
        
        func subTitle() -> String {
            return ""
        }
    }
    
    public class DataSingleGroupModel: XC_DataChannelFormatterItem, XC_DataChannelItemType {
        struct singleRowItem {
            let p_cn: String
            let p_en: String
            let p_logo: String
            let dgn_num: String
            
           //View Model
            var rowH: CGFloat
            var iconUrl: URL?
            var nameTitle: String
            var dataTitle: String
            
            init(json: JSON) {
                p_cn = json["info", "p_cn"].stringValue
                p_en = json["info", "p_en"].stringValue
                p_logo = json["info", "p_logo"].stringValue
                dgn_num = json["dgn_num"].stringValue
                
                rowH = 0
                iconUrl = URL(string: p_logo)
                nameTitle = ""
                dataTitle = ""
                
                if !p_cn.isEmpty && (!p_en.isEmpty) {
                    if p_en == p_cn  {
                        nameTitle = p_cn
                    } else {
                        nameTitle = p_cn + " " + p_en
                    }
                } else {
                    let str = !p_cn.isEmpty ? p_cn : p_en
                    nameTitle = str.with(placeholder: placeholderStr)
                }
                
                dataTitle = dgn_num.with(placeholder: placeholderStr)
                
                let attributes = [NSFontAttributeName: UIFont(name: SEMIBOLD, size: 20 * 0.6)!]
                let nameW = 260 - XC_DATA_ICON_H - 5 - 10   //10是尾部文字间距
                let dataW = screenW * 0.75 - 40 - 260 - 10
                let nameH = nameTitle.height(attributes: attributes, size: CGSize(width: nameW, height: CGFloat.infinity))
                let dataH = dataTitle.height(attributes: attributes, size: CGSize(width: dataW, height: CGFloat.infinity))
                rowH = nameH > dataH ? nameH : dataH
                rowH = rowH < 23 ? 23 : rowH
            }
        }
        
        public let type: Int
        let dg_wh: String
        let name: String
        let cl_id2: String
        let time: String
        
        var rows = [singleRowItem]()
        let singleGroupListH: CGFloat
        
        init(json: JSON) {
            type = json["type"].intValue
            dg_wh = json["dg_wh"].stringValue
            name = json["name"].stringValue
            cl_id2 = json["cl_id2"].stringValue
            time = json["b", "time"].stringValue
            for (_, subJson):(String, JSON) in json["content"] {
                rows.append(singleRowItem(json: subJson))
            }
            
            var headerH = 55
            switch XC_DEVICE_TYPE {
            case .series_4, .series_5:
                headerH = 45
            default:
                break
            }

            singleGroupListH = rows
                .map({singleRowItem in
                    singleRowItem.rowH
                })
                .reduce(0, {(res,rowH) in
                    res + rowH + 5
                }) + CGFloat(headerH) + 10
        }
        
        public func numberOfRows() -> Int {
            return self.rows.count
        }
        
        public func numberOfSections() -> Int {
            return 1
        }
        
        public func mainTitle() -> String {
            return name.with(placeholder: placeholderStr)
        }
        
        public func subTitle() -> String {
            let dg_wh = self.dg_wh.with(placeholder: placeholderStr)
            let time = self.time.with(placeholder: placeholderStr)
            let cl_id2 = self.cl_id2.with(placeholder: placeholderStr)
            return "地区: " + dg_wh + " /  时间: " + time + " / 单位: " + cl_id2
        }
    }

    public class DataMutiGroupModel: XC_DataChannelFormatterItem, XC_DataChannelItemType {
        struct singleRowItem {
            let p_cn: String
            let p_en: String
            let p_logo: String
            var values: [String]? = []
            var rowH: CGFloat = 0
            //View Model
            var iconUrl: URL? {
                return URL(string: p_logo)
            }
            
            var titles: [String] {
                var name: String
                if !p_cn.isEmpty && !p_en.isEmpty {
                    if p_en == p_cn  {
                        name = p_cn
                    } else {
                        name = p_cn + " " + p_en
                    }
                } else {
                    name = !p_cn.isEmpty ? p_cn : p_en
                }
                
                return [name] + values!
            }
        }
        
        public let type: Int
        let dg_name: String
        let time: String
        let dg_l: String //地区
        let cl_id2: String //单位
        var colNames = [String]()
        var rows = [singleRowItem]() //表示单个数据,表示一行,与表现形式无关,有多少产品条目就有几行
        
        //view model
        var tables:[[singleRowItem]] = []
        var colWidths: [[CGFloat]] = [] //每张表的列宽
        var mutiGroupListH: CGFloat
        
        init(json: JSON) {
            type = json["type"].intValue
            dg_name = json["title", "dg_name"].stringValue
            time = json["title", "c", "time"].stringValue
            dg_l = json["title", "dg_l"].stringValue
            cl_id2 = json["title", "cl_id2"].stringValue
            
            var col_names = [String]()
            for (_, subJson):(String, JSON) in json["datas", "canshu"] {
                col_names.append(subJson["col_name"].stringValue)
            }
            colNames = col_names
            
            //将列名封装成Item
            let colNamesItem = singleRowItem(p_cn: "", p_en: "", p_logo: "", values: col_names, rowH: 0)
            rows.append(colNamesItem)
            
            for (_, subJson):(String, JSON) in json["datas", "name"] {
                let p_cn = subJson["p_cn"].stringValue
                let p_en = subJson["p_en"].stringValue
                let p_logo = subJson["p_logo"].stringValue
                let item = singleRowItem(p_cn: p_cn, p_en: p_en, p_logo: p_logo, values: [], rowH: 0)
                rows.append(item)
            }
            
            let col_count = col_names.count
            for (idx, subJson):(String, JSON) in json["datas", "val"] {
                let row = Int(idx)! / col_count
                //加1,原因是列名是第一行,已经设置
                rows[row+1].values?.append(subJson["dgn_num"].stringValue + subJson["cl_id"].stringValue)
            }
            
            //viewModel 创建   实现每行最多3列, 分表显示
            //1.计算成分割成多少张表
            let tableCount = self.colNames.count > 0 ? ((colNames.count-1) / 3 + 1) : 0
            
            //分割成多张表
            var headerH = 55
            var textFont = UIFont(name: SEMIBOLD, size: 12)
            switch XC_DEVICE_TYPE {
            case .series_4, .series_5:
                headerH = 45
                textFont = UIFont(name: SEMIBOLD, size: 10)
            default:
                break
            }
            
            let attributes = [NSFontAttributeName: textFont!]
            for i in 0..<tableCount {
                var table = [singleRowItem]()
                let tableColNames: [String] = DataMutiGroupModel.divideArrInGroupSeq(source: colNames, index: i, eachCount: 3) as! [String]
                let colWidths = DataMutiGroupModel.colWidths(colCount: tableColNames.count)
                self.colWidths.append(colWidths)
                let colNameRowH = tableColNames
                    .combine(target: colWidths.dropFirst().map({ $0 - 10 }))
                    .map({ (str, width) in
                        str.height(attributes: attributes, size: CGSize(width: width, height: CGFloat.infinity))
                    })
                    .reduce(23, {(res, height) in
                        res < height ? height : res
                    })
                let colNamesItem = singleRowItem(p_cn: "", p_en: "", p_logo: "", values: tableColNames, rowH: colNameRowH)
                table.append(colNamesItem)
                
                for j in 1..<self.rows.count {
                    //第0行是列名,放最外边计算
                    let item = self.rows[j]
                    let values = DataMutiGroupModel.divideArrInGroupSeq(source: item.values!, index: i, eachCount: 3) as! [String]
                    
                    let rowH = values
                        .combine(target: colWidths.dropFirst().map({ $0 - 10}))
                        .map({ (str, width) in
                            str.height(attributes: attributes, size: CGSize(width: width, height: CGFloat.infinity))
                        })
                        .reduce(23, {(res, height) in
                            res < height ? height : res
                        })
//                    print("多组数据-----------\(rowH)")
                    let rowItem = singleRowItem(p_cn: item.p_cn, p_en: item.p_en, p_logo: item.p_logo, values: values, rowH: rowH)
                    table.append(rowItem)
                }
                tables.append(table)
            }
            mutiGroupListH = self.tables
                .map({ singleRowItems in
                    singleRowItems.map({singleRowItem in
                        singleRowItem.rowH
                    })
                        .reduce(0, { (res, rowH) in
                            res + rowH + 5
                        })
                }).reduce(0, { (res, tableH) in
                    res + tableH
                })
            mutiGroupListH += CGFloat(self.tables.count * 10) + CGFloat(headerH)
        }
        
        static func divideArrInGroupSeq(source: [Any], index: Int, eachCount: Int) -> [Any]{
            //将数组的元素每eachCount个一组,不够个数的也算一组,按顺序取
            let groupCount = (source.count-1) / eachCount + 1
            if index < 0 || index > groupCount-1 {
                return [Any]()
            }
            var targetArr: [Any]
            if index == groupCount-1 {
                //最后一组需要特殊处理,可能不足eachCount个
                targetArr = source[(index * eachCount)..<source.endIndex].map({$0})
            } else {
                targetArr = source[(index * eachCount)...(index * eachCount + eachCount-1)].map({$0})
            }
            return targetArr
        }
        
        static func colWidths(colCount: Int) -> [CGFloat] {
            //值列最多三列  返回数组包含了name列
            if colCount == 1 {
                return [260, screenW * 0.75 - 20 - 260]
            } else if colCount == 2 {
                let firstValueColW = (screenW * 0.75 - 20 - NAME_COL_W) / 3
                let secondValueColW = screenW * 0.75 - 20 - NAME_COL_W - firstValueColW
                return [NAME_COL_W, firstValueColW, secondValueColW]
            } else {
                let w = (screenW * 0.75 - 20 - NAME_COL_W) / 3
                return [NAME_COL_W, w, w, w]
            }
        }

        
        public func numberOfRows() -> Int {
            return self.rows.count
        }
        
        public func numberOfSections() -> Int {
            return self.tables.count
        }
        
        public func mainTitle() -> String {
            return dg_name.with(placeholder: placeholderStr)
        }
        
        public func subTitle() -> String {
            let dg_l = self.dg_l.with(placeholder: placeholderStr)
            let time = self.time.with(placeholder: placeholderStr)
            let cl_id2 = self.cl_id2.with(placeholder: placeholderStr)
            return "地区: " + dg_l + " /  时间: " + time + " / 单位: " + cl_id2
        }
        
        public func rowH(at: Int) -> CGFloat {
            return 0
        }
    }
    
}
    
