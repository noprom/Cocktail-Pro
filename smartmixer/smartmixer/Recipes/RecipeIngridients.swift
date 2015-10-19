//
//  RecipeIngridients.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/21.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit
import CoreData

class RecipeIngridients: UIViewController, UIScrollViewDelegate,UICollectionViewDelegate {
    
    @IBOutlet var segmentView:UICollectionView!
    
    @IBOutlet var imageScroll:UIScrollView!
    
    @IBOutlet var moreinfo:UILabel!
    
    var size:CGSize=CGSize(width: 320, height: 385)
    
    var ViewSize:CGSize=CGSize(width: 500, height: 520)
    
    var separator:UIView!
    
    //当前的酒单id
    var recipeId:Int!=0
    
    //显示的对象组
    var segmentCells:[[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        separator = UIView(frame: CGRect(x: 10, y: 35, width: 80, height: 3) )
        separator.backgroundColor = UIColor(red: 245/255, green: 164/255, blue: 9/255, alpha: 1)
        segmentView.addSubview(separator)
        
        getDataReady()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //#MARK:这里是开始处理图片滚动的地方
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(scrollView.tag == 1){
            let percent = imageScroll.contentOffset.x / imageScroll.contentSize.width
            
            let posx:Int = Int(10+CGFloat(100*segmentCells.count)*percent)
            
            separator.frame = CGRect(x: posx, y: 35, width: 80, height: 3)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(scrollView.tag == 1){
            let offset:CGFloat!=imageScroll.contentOffset.x
            let index:Int = Int(offset/imageScroll.frame.width)
            let indexPath = NSIndexPath(forItem: index, inSection: 0)
            segmentView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
            var segmentCell = segmentCells[index]
            moreinfo.text = segmentCell[2]
        }
    }
    //#MARK:下面是数据处理的部分
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        imageScroll.contentSize = CGSize(width: imageScroll.frame.width * CGFloat(segmentCells.count), height: imageScroll.frame.height)
        return segmentCells.count
    }
    
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var item = segmentCells[indexPath.item]
        let segmentCell = segmentView.dequeueReusableCellWithReuseIdentifier("segmentCell", forIndexPath: indexPath) as! SegmentCell
        segmentCell.name.text=item[0]
        segmentCell.nameEng.text=item[1]
        segmentCell.extendInfo = item[2]
        let rect = CGRect(x: CGFloat(indexPath.item) * imageScroll.frame.width, y: CGFloat(0), width: imageScroll.frame.width, height: imageScroll.frame.height)
        let imgView = UIImageView(frame:rect)
        imgView.contentMode=UIViewContentMode.ScaleAspectFit
        imgView.image = UIImage(named: item[3])
        imageScroll.addSubview(imgView)
        return segmentCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let rect = CGRect(x: CGFloat(indexPath.item) * imageScroll.frame.width, y: CGFloat(0), width: imageScroll.frame.width, height: imageScroll.frame.height)
        segmentView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        let segmentCell = collectionView.cellForItemAtIndexPath(indexPath) as! SegmentCell
        moreinfo.text = segmentCell.extendInfo
        imageScroll.scrollRectToVisible(rect, animated: true)
    }
    
    func getDataReady(){
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName("RecipeStep", inManagedObjectContext: managedObjectContext)
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        fetchRequest.predicate =  NSPredicate(format: "recipeId == \(recipeId)")
        
        do {
            var steps:[RecipeStep] = try managedObjectContext.executeFetchRequest(fetchRequest) as! [RecipeStep]
            for( var index = 0; index != steps.count; index++){
                let item = steps[index]
                if(item.actionId == 1 || item.actionId == 20){//需要容器的
                    let container = getOneContainer(item.ingridientId.integerValue)
                    segmentCells.insert([container.name,container.nameEng,"",container.thumb], atIndex: 0)
                }else if(item.actionId == 3){//需要材料的
                    let ingridient = getOneIngridient(item.ingridientId.integerValue)
                    segmentCells.append([ingridient.name,ingridient.nameEng,"\(item.amount)"+UnitDictory[item.unitId.integerValue]!,ingridient.thumb])
                    
                }
            }
        }catch{
            abort()
        }
//        var steps:[RecipeStep] = try managedObjectContext.executeFetchRequest(fetchRequest) as! [RecipeStep]
    }
    
    func getOneContainer(id:Int) -> Container{
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("Container", inManagedObjectContext: managedObjectContext)
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        
        var error: NSError? = nil
        
        var items:[Container] = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as! [Container]
        
        if(items.count==0){
            abort()
        }else{
            return items[0]
        }
        
    }
    
    func getOneIngridient(id:Int) -> Ingridient{
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("Ingridient", inManagedObjectContext: managedObjectContext)
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        
        var error: NSError? = nil
        
        var items:[Ingridient] = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as! [Ingridient]
        
        if(items.count==0){
            abort()
        }else{
            return items[0]
        }
        
    }
}
