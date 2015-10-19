//
//  MaterialDetail.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-24.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit
import CoreData

class IngredientDetail: UIViewController {
    
    @IBOutlet var image:UIImageView!
    
    @IBOutlet var myscrollView:UIScrollView!
    
    @IBOutlet var navtitle:UINavigationItem!
    
    @IBOutlet var name:UILabel!
    
    @IBOutlet var nameEng:UILabel!
    
    @IBOutlet var iHave:UIImageView!
    
    @IBOutlet var desc:UITextView!
    
    @IBOutlet var alcohol:UILabel!
    
    @IBOutlet var showBt:UIButton!
    
    //描述的高度
    @IBOutlet var hDesc: NSLayoutConstraint!
    
    //主框架的高度
    @IBOutlet var hMainboard: NSLayoutConstraint!
    
    //当前的材料
    var ingridient:Ingridient!
    
    override func viewDidLoad() {
        //self
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        if(ingridient != nil){
            navtitle.title = ingridient.name
            name.text = ingridient.name
            nameEng.text  = ingridient.nameEng
            if(ingridient.ihave == true){
                iHave.image = UIImage(named: "Heartyes.png")
            }else{
                iHave.image = UIImage(named: "Heartno.png")
            }
            desc.text = ingridient.desc
            let size = ingridient.desc.textSizeWithFont(self.desc!.font!, constrainedToSize: CGSize(width:300, height:1000))
            if(size.height<100){
                showBt.hidden = true
            }
            image.image = UIImage(named: ingridient.thumb)
        }
        if(deviceDefine==""){//添加向右滑动返回
            let slideback = UISwipeGestureRecognizer()
            slideback.addTarget(self, action: "SwipeToBack:")
            slideback.direction = UISwipeGestureRecognizerDirection.Right
            self.view.addGestureRecognizer(slideback)
            self.view.userInteractionEnabled = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(myscrollView != nil){
            myscrollView.contentSize = CGSize(width: 320, height: 900)
            self.view.layoutIfNeeded()
        }
    }
    
    class func IngredientDetailInit()->IngredientDetail{
        let ingredientDetail = UIStoryboard(name:"Ingredients"+deviceDefine,bundle:nil).instantiateViewControllerWithIdentifier("ingredientDetail") as! IngredientDetail
        return ingredientDetail
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func SwipeToBack(sender:UISwipeGestureRecognizer){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    var webView:WebView!
    
    @IBAction func tuBuy(sender: UIButton){
        webView=WebView.WebViewInit()
        webView.myWebTitle="商城"
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    //我有按钮发生了点击
    @IBAction func haveClick(sender:UIButton){
        ingridient.ihave = !ingridient.ihave.boolValue
        if(ingridient.ihave == true){
            iHave.image = UIImage(named: "Heartyes.png")
            UserHome.addHistory(2, id: ingridient.id.integerValue, thumb: ingridient.thumb, name: ingridient.name)
        }else{
            iHave.image = UIImage(named: "Heartno.png")
            UserHome.removeHistory(2, id: ingridient.id.integerValue)
        }
        do {
            try managedObjectContext.save()
        } catch {
            abort()
        }
    }
    
    //显示所有的文字
    @IBAction func showAllText(sender:UIButton){
        if(hMainboard.constant == 250){
            let str:String = desc.text!
            let size = str.textSizeWithFont(desc!.font!, constrainedToSize: CGSize(width:300, height:1000))
            if(size.height > (hDesc!.constant-20)){
                /**/
                UIView.animateWithDuration(0.4, animations: {
                    self.hMainboard.constant = 150 + size.height;
                    self.hDesc.constant = size.height + 20;
                    self.view.layoutIfNeeded();
                    }, completion: { _ in
                        sender.titleLabel!.text = "《收起";
                })
                /**/
            }
        }else{
            /**/
            UIView.animateWithDuration(0.4, animations: {
                self.hMainboard.constant = 250
                self.hDesc.constant = 125
                self.view.layoutIfNeeded()
                }, completion: { _ in
                    sender.titleLabel!.text = "全部》"
            })
            /**/
        }
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        //let sectionInfo = self.fetchedResultsController.sections[section] as NSFetchedResultsSectionInfo
        //return sectionInfo.numberOfObjects
        return 0
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        _ = indexPath.row
        _ = indexPath.section
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("aboutRecipe", forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        _ = collectionView.cellForItemAtIndexPath(indexPath) as! IngredientThumb
        _ = UIStoryboard(name:"Ingredients",bundle:nil).instantiateViewControllerWithIdentifier("ingredientDetail") as! IngredientDetail
        //self.navigationController.pushViewController(materials, animated: true)
    }
    
}
