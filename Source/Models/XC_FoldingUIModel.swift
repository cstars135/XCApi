//
//  XC_FoldingUIModel.swift
//  XCBusiness
//
//  Created by Cstars on 2017/1/17.
//  Copyright © 2017年 xincheng.tv. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct UnfoldSection {
    var title: String
    var items = [UnfoldItem]()
}

public protocol UnfoldItem {
    var iconUrl: URL? { get }
    var indexPath: IndexPath? { get set }
    var firstTitle: String { get }
    var secondTitle: String { get }
    var detailDescribe: String { get }
    var n_id: Int { get }
}

///已折叠模型
public protocol FoldItem: Model {
    init(json: JSON)
//    static func create(json: JSON) -> FoldItem
    var iconUrl: URL? { get }
    
    var leftFirstTitle: String { get }
    var leftSecondTitle: String { get }
    
    var leftLineTopTitle: String? { get } //若没有紧挨分割线的标题则为返回nil
    var leftBottomTitle: String { get }
    
    var rightTitles: [String]? { get }  //支持 0-4个之间变化
    var rightNumberTitles: [String]? { get } //支持 0-4个之间变化
    
    var news: UnfoldItem? { get set }
    var unfoldTitles: [String]? { get }
    var unfoldItems: [UnfoldSection]? { get set }
}

extension FoldItem {
    public var unfoldTitles: [String]? {
        get {
            if let unfoldItems = unfoldItems {
                var titles = unfoldItems.map({ (x) -> String in
                    x.title + " / \(x.items.count)"
                })
                if titles.count > 4 {
                    titles.removeSubrange(Range(uncheckedBounds: (lower: 4, upper: titles.count-1)))
                }
                return titles
            }
            return nil
        }
    }
    
    public var rightTitles: [String]? {
        get {
            if let unfoldItems = unfoldItems {
                var titles = unfoldItems.map({ (x) -> String in
                    x.title
                })
                if titles.count > 4 {
                    titles.removeSubrange(Range(uncheckedBounds: (lower: 4, upper: titles.count-1)))
                }
                return titles
            }
            return nil
        }
    }
    
    public var rightNumberTitles: [String]? {
        get {
            if let unfoldItems = unfoldItems {
                var titles = unfoldItems.map({ (x) -> String in
                    "\(x.items.count)"
                })
                if titles.count > 4 {
                    titles.removeSubrange(Range(uncheckedBounds: (lower: 4, upper: titles.count-1)))
                }
                return titles
            }
            return nil
        }
    }
}



protocol XC_FoldingDataSource: class {
    func create() -> XC_FoldingDataSource
    var foldItems: [FoldItem]? { get set }
    
    func numberOfFoldRows() -> Int //未展开显示个数
    func numberOfUnfoldSections(at row: Int) -> Int //展开section个数
    func numberOfUnfoldRowsInSection(foldRow:Int, section: Int) -> Int  //展开
    
    func heightForContent() -> CGFloat //表示展开与未展开的内容展示view高度
    func heightForHeader() -> CGFloat //表示展开后各个section header的高度
    func removeUnflodItem(row: Int, indexPath: IndexPath) -> UnfoldItem
    func clone() -> XC_FoldingDataSource
}

extension XC_FoldingDataSource {
    func numberOfFoldRows() -> Int {
        if let foldItems = self.foldItems {
            return foldItems.count
        }
        return 0
    }
    
    func numberOfUnfoldRowsInSection(foldRow: Int, section: Int) -> Int{
        if let folditem = self.foldItems?[foldRow], let unfoldItems = folditem.unfoldItems {
            return unfoldItems[section].items.count
        }
        return 0
    }
    
    func numberOfUnfoldSections(at row: Int) -> Int {
        if let foldItem = self.foldItems?[row], let unflodItems = foldItem.unfoldItems {
            return unflodItems.count
        }
        return 0
    }

}

extension XC_FoldingDataSource {
    func heightForContent() -> CGFloat {
        return 100
    }
    
    func heightForHeader() -> CGFloat {
        return 30
    }
    
    func removeUnflodItem(row: Int, indexPath: IndexPath) -> UnfoldItem {
        var foldItem = self.foldItems![row]
        let unflodItem = (foldItem.unfoldItems?[indexPath.section].items.remove(at: indexPath.row))!
        if foldItem.unfoldItems?[indexPath.section].items.count == 0 {
            foldItem.unfoldItems?.remove(at: indexPath.section)
        }
        self.foldItems![row] = foldItem
        return unflodItem
    }
    
    func removeAll(){
        self.foldItems?.removeAll()
    }
    
    func remove(at: Int) {
        self.foldItems?.remove(at: at)
    }
    
    func append(items:[FoldItem]){
        self.foldItems?.append(contentsOf: items)
    }
    
    func insert(_ item: FoldItem ,at: Int) {
        self.foldItems?.insert(item, at: at)
    }
    
    func append(items:[Any]){
        self.foldItems?.append(contentsOf: (items as! [FoldItem]))
    }
    
    func clone() -> XC_FoldingDataSource {
        let dataSource = create()
        let foldItems = self.foldItems
        dataSource.foldItems = foldItems
        return dataSource
    }
}
