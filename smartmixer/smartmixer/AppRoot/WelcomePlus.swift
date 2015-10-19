//
//  WelcomePlusViewController.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/10/15.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit

class WelcomePlus: UIViewController ,UIScrollViewDelegate {
    
    @IBOutlet var page1_bg:UIImageView!
    @IBOutlet var page2_bg:UIImageView!
    @IBOutlet var page3_bg:UIImageView!
    @IBOutlet var page4_bg:UIImageView!
    @IBOutlet var page5_bg:UIImageView!
    
    @IBOutlet var pageControl:UIPageControl!
    
    @IBOutlet var startButton:UIButton!
    
    @IBOutlet var scrollview:UIScrollView!
    
    var rect:CGRect!
    
    var firstPop:Bool=true
    
    class func WelcomePlusInit()->WelcomePlus{
        let welcomePlus = UIStoryboard(name:"Launch"+deviceDefine,bundle:nil).instantiateViewControllerWithIdentifier("welcomePlus") as! WelcomePlus
        return welcomePlus
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        if(osVersion<8 && deviceDefine != ""){
            rect = CGRect(x: 0, y: 0, width: self.view.frame.height, height: self.view.frame.width)
        }
        
        //scrollview = UIScrollView(frame: rect)
        scrollview.bounces = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.pagingEnabled = true
        scrollview.contentSize = CGSize(width: rect.width*5, height: 0)
        scrollview.delegate = self
        self.view.addSubview(scrollview)
        var more = ""
        if(deviceDefine==""){
            more = "_I"
        }
        for index in 1...5{
            let view = UIImageView()
            view.frame = CGRect(x: rect.width*(CGFloat(index)-1), y: 0, width: rect.width, height: rect.height)
            view.image = UIImage(named: "page\(index)_center\(more).png")
            scrollview.addSubview(view)
        }
        
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = 5
    }
    
    @IBAction func clicktoHidden(sender:UIButton){
        UIView.animateWithDuration(0.3,
            animations : {
                self.view.alpha = 0
            },
            completion : {_ in
                if(self.firstPop){
                    self.view.removeFromSuperview()
                }else{
                    self.dismissViewControllerAnimated(false, completion: nil)
                }
            }
        )
    }
    
    
    
    //@MARK:滚动部分的处理
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offset:CGFloat!=scrollview.contentOffset.x
        let index:Int = Int( offset / scrollview.frame.width)
        self.pageControl.currentPage = index
    }
    
    @IBAction func pageControlChanged(sender: UIPageControl) {
        let left = scrollview.frame.width * CGFloat(self.pageControl.currentPage)
        let rect = CGRect(x:left, y: 0, width: scrollview.frame.width, height: scrollview.frame.height)
        self.scrollview.scrollRectToVisible(rect, animated: true)
    }
    
    var setalpha:Bool=false
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x
        let diff = scrollView.contentOffset.x % rect.width
        
        switch offset {
        case 0...(rect.width-1):
            page1_bg.alpha = 1-(diff/rect.width)
            page2_bg.alpha = diff/rect.width
        case rect.width...(rect.width*2-1):
            page2_bg.alpha = 1-(diff/rect.width)
            page3_bg.alpha = diff/rect.width
        case rect.width*2...(rect.width*3-1):
            page3_bg.alpha = 1-(diff/rect.width)
            page4_bg.alpha = diff/rect.width
        case rect.width*3...(rect.width*4-1):
            page4_bg.alpha = 1-(diff/rect.width)
            page5_bg.alpha = diff/rect.width
            startButton.alpha = 0
        case rect.width*4...(rect.width*5-1):
            page5_bg.alpha = 1
            startButton.alpha = 1
            self.view.bringSubviewToFront(startButton)
        default:
            NSLog("\(offset)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
