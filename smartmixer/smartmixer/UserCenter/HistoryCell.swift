//
//  HistoryCell.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/10/5.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit

//自定义一个搜索设置完毕开始搜索的消息
protocol HistoryCellDelegate:NSObjectProtocol{
    func historyCell(sender:HistoryCell)
    func historyCell(sender:HistoryCell,show ShowCell:Bool)
}

class HistoryCell: UITableViewCell,UIScrollViewDelegate {
    
    //需要显示的图标
    @IBOutlet var thumb:UIImageView!
    //需要显示的物品名字
    @IBOutlet var name:UILabel!
    //需要显示的时间
    @IBOutlet var time:UILabel!
    //滚动视图
    @IBOutlet var scroll:UIScrollView!
    
    var delegate:HistoryCellDelegate!
    
    @IBAction func deleteitem(sender:UIButton){
        if(delegate != nil){
            self.delegate.historyCell(self)
        }
    }
    
    @IBAction func resetScroll(sender:UIButton){
        if(scroll != nil){
            if(scroll.contentOffset.x==0){
                if(delegate != nil){
                    self.delegate.historyCell(self,show:true)
                }
            }else{
                scroll.contentOffset.x = 0
            }
        }else if(delegate != nil){
            self.delegate.historyCell(self,show:true)
        }
        
    }

}
