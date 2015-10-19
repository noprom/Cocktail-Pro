//
//  RecipeDetailPhone.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/15.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit
import CoreData

class RecipeDetailPhone: UIViewController {
    
    var CurrentData:Recipe!
    
    //大图
    @IBOutlet var image:UIImageView!
    
    //名字
    @IBOutlet var name:UILabel!
    
    //英文名字
    @IBOutlet var nameEng:UILabel!
    
    //是否收藏
    @IBOutlet var faver:UIImageView!
    
    //描述
    @IBOutlet var desc:UITextView!
    
    //口感
    @IBOutlet var property:UISegmentedControl!
    
    //卡路里
    @IBOutlet var calorie:UILabel!
    
    //覆盖度
    @IBOutlet var coverd:UILabel!
    
    //酒精度
    @IBOutlet var alchol:UILabel!
    
    //难度
    @IBOutlet var difficulty:UILabel!
    
    //描述的高度
    @IBOutlet var hDesc: NSLayoutConstraint!
    
    //主框架的高度
    @IBOutlet var hMainboard: NSLayoutConstraint!
    
    
    @IBOutlet var scrollview:UIScrollView!
    
    @IBOutlet var navTitle:UINavigationItem!
    
    @IBOutlet var ingridientView:UIView!
    
    //显示详细的窗口
    var popview:PopupView! = nil
    
    var moresize:CGFloat = 0
    
    class func RecipesDetailPhoneInit()->RecipeDetailPhone{
        let recipeDetail = UIStoryboard(name: "Recipes"+deviceDefine, bundle: nil).instantiateViewControllerWithIdentifier("recipeDetail") as! RecipeDetailPhone
        return recipeDetail
    }
    
    override func viewDidLoad() {
        rootController.showOrhideToolbar(false)
        super.viewDidLoad()
        //添加向右滑动返回
        let slideback = UISwipeGestureRecognizer()
        slideback.addTarget(self, action: "SwipeToBack:")
        slideback.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(slideback)
        self.view.userInteractionEnabled = true
        let left = UIBarButtonItem(title: "开始制作", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("toCook:"))
        self.navigationItem.rightBarButtonItem = left
        if(CurrentData != nil){
            self.image.image = UIImage(named: CurrentData.thumb)
            self.name.text = "\(CurrentData.name)"
            if(navTitle != nil){
                navTitle.title = "\(CurrentData.name)"
            }
            self.nameEng.text = "\(CurrentData.nameEng)"
            if(CurrentData.isfavorite == true){
                self.faver.image = UIImage(named: "Heartyes.png")
            }else{
                self.faver.image = UIImage(named: "Heartno.png")
            }
            
            self.desc.text = CurrentData.des
            
            property.removeAllSegments()
            if(CurrentData.taste.integerValue == 0){
                property.insertSegmentWithTitle("甜味", atIndex: 0, animated: false)
            }else if(CurrentData.taste.integerValue == 1){
                property.insertSegmentWithTitle("中味", atIndex: 0, animated: false)
            }else if(CurrentData.taste.integerValue == 2){
                property.insertSegmentWithTitle("辣味", atIndex: 0, animated: false)
            }
            if(CurrentData.skill.integerValue == 0){
                property.insertSegmentWithTitle("兑和", atIndex: 1, animated: false)
            }else if(CurrentData.skill.integerValue == 1){
                property.insertSegmentWithTitle("摇和", atIndex: 1, animated: false)
            }else if(CurrentData.skill.integerValue == 2){
                property.insertSegmentWithTitle("调和", atIndex: 1, animated: false)
            }else if(CurrentData.skill.integerValue == 3){
                property.insertSegmentWithTitle("搅和", atIndex: 1, animated: false)
            }else{
                property.insertSegmentWithTitle("漂浮", atIndex: 1, animated: false)
            }
            if(CurrentData.drinktime.integerValue == 0){
                property.insertSegmentWithTitle("餐前", atIndex: 2, animated: false)
            }else if(CurrentData.drinktime.integerValue == 1){
                property.insertSegmentWithTitle("餐后", atIndex: 2, animated: false)
            }else if(CurrentData.drinktime.integerValue == 2){
                property.insertSegmentWithTitle("全天", atIndex: 2, animated: false)
            }
            self.alchol.text = "\(CurrentData.alcohol)°"
            self.calorie.text = "\(CurrentData.calorie) 卡"
            self.coverd.text = String(format:"%.0f", CurrentData.coverd.doubleValue*100)+"%"
            self.difficulty.text = CurrentData.difficulty.stringValue
        }
        
        if(ingridientView != nil){
            recipeIngridients = UIStoryboard(name: "Recipes", bundle: nil).instantiateViewControllerWithIdentifier("recipeIngridients")as! RecipeIngridients
            recipeIngridients.recipeId = CurrentData.id.integerValue
            recipeIngridients.view.frame = CGRect(origin: CGPoint(x: 0, y: 34), size: recipeIngridients.size)
            ingridientView.addSubview(recipeIngridients.view)
            
        }
        
    }
    
    var recipeIngridients:RecipeIngridients!
    
    var stepnum:Int = 0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stepHeight.constant = CGFloat(stepnum * 44 + 40)
        scrollHeight.constant = CGFloat(stepnum * 44)
        scrollview!.contentSize = CGSize(width: scrollview!.contentSize.width, height: CGFloat(1320+stepnum*44))
        self.view.layoutIfNeeded()
    }
    
    @IBOutlet var scrollHeight:NSLayoutConstraint!
    
    @IBOutlet var stepHeight:NSLayoutConstraint!
    
    @IBOutlet var stepScrollView:UIScrollView!
    
    //告知窗口现在有多少个item需要添加
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        let sectionInfo = self.fetchedStepsController.sections!
        let item = sectionInfo[section]
        stepnum = item.numberOfObjects
        return stepnum
    }
    
    //处理单个View的添加
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let tableCell = tableView.dequeueReusableCellWithIdentifier("stepCell")!
        let item = self.fetchedStepsController.objectAtIndexPath(indexPath) as! RecipeStep
        tableCell.textLabel?.text = "\((indexPath.row+1)). "+item.stepInfo
        return tableCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //显示所有的文字
    @IBAction func showAllText(sender:UIButton){
        if(hMainboard.constant == 280){
            let str:String = desc.text!
            NSLog(str)
            let size = str.textSizeWithFont(self.desc.font!, constrainedToSize: CGSize(width:304, height:1000))
            if(size.height > (hDesc!.constant-28)){
                /**/
                UIView.animateWithDuration(0.4, animations: {
                    self.hMainboard.constant = 178 + size.height;
                    self.hDesc.constant = size.height + 28;
                    self.view.layoutIfNeeded();
                    }, completion: { _ in
                        sender.titleLabel!.text = "《收起";
                })
                /**/
            }
        }else{
            /**/
            UIView.animateWithDuration(0.4, animations: {
                self.hMainboard.constant = 280
                self.hDesc.constant = 120
                self.view.layoutIfNeeded()
                }, completion: { _ in
                    sender.titleLabel!.text = "全部》"
            })
            /**/
        }
    }
    
    @IBAction func clickFaver(sender:UIButton){
        CurrentData.isfavorite = !CurrentData.isfavorite.boolValue
        if(CurrentData.isfavorite == true){
            self.faver?.image = UIImage(named: "Heartyes.png")
            UserHome.addHistory(1, id: CurrentData.id.integerValue, thumb: CurrentData.thumb, name: CurrentData.name)
        }else{
            self.faver?.image = UIImage(named: "Heartno.png")
            UserHome.removeHistory(1, id: CurrentData.id.integerValue)
        }
        do {
            try managedObjectContext!.save()
        } catch {
            abort()
        }
    }
    
    func SwipeToBack(sender:UISwipeGestureRecognizer){
        self.navigationController?.popViewControllerAnimated(true)
        rootSideMenu.needSwipeShowMenu = true
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        rootSideMenu.needSwipeShowMenu = true
    }
    
    
    //点击去制作
    @IBAction func toCook(sender:UIButton){
    }
    
    //详情的分类
    var fetchedStepsController: NSFetchedResultsController {
        if (_fetchedStepsController != nil) {
            return _fetchedStepsController!
        }
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("RecipeStep", inManagedObjectContext: managedObjectContext)
        fetchRequest.entity = entity
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        let condition = NSPredicate(format: "recipeId == \(CurrentData.id)")
        fetchRequest.predicate = condition
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        _fetchedStepsController = aFetchedResultsController
        do{
            try _fetchedStepsController!.performFetch()
        } catch{
            abort()
        }
//        var error: NSError? = nil
//        if !_fetchedStepsController!.performFetch(&error) {
//            abort()
//        }
        return _fetchedStepsController!
    }
    
    var _fetchedStepsController: NSFetchedResultsController? = nil
    
}
