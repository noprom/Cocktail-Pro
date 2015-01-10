//
//  RecipeThumbail.swift
//  smartmixer
//
//  Created by Koulin Yuan on 8/17/14.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

import UIKit
import CoreData

@IBDesignable class RecipeThumbail : UICollectionViewCell {
    
    @IBOutlet var thumbnailImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!

    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var favButton: UIImageView!
    
    @IBOutlet var alcohol:UILabel!
    
    @IBOutlet var nameEng:UILabel!
    
    @IBOutlet var coverd:UILabel!
    
    
    @IBInspectable var borderColor:UIColor = UIColor.grayColor(){
        didSet{
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 1 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var cornerRadius:CGFloat = 10 {
        didSet{
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBAction func favClick(sender: UIButton) {
        CurrentRecipe.isfavorite = !CurrentRecipe.isfavorite.boolValue
        if(CurrentRecipe.isfavorite == true){
            favButton.image = UIImage(named: "Heartyes.png")
            UserHome.addHistory(1, id: CurrentRecipe.id.integerValue, thumb: CurrentRecipe.thumb, name: CurrentRecipe.name)
        }else{
            favButton.image = UIImage(named: "Heartno.png")
            UserHome.removeHistory(1, id: CurrentRecipe.id.integerValue)
        }
        var error: NSError? = nil
        if !managedObjectContext.save(&error) {
            abort()
        }
    }
    
    var CurrentRecipe:Recipe!
    
    func SetDataContent(item:Recipe){
        CurrentRecipe = item
        self.tag = item.id.integerValue
        self.nameLabel.text = item.name
        self.nameEng.text = item.nameEng
        self.descriptionLabel.text = item.des
        self.alcohol.text = "\(item.alcohol) °"
        self.coverd.text = String(format:"%.0f", item.coverd.doubleValue*100)+"%"
        self.thumbnailImage.image = UIImage(named: item.thumb)
        if(item.isfavorite == true){
            favButton.image = UIImage(named: "Heartyes.png")
        }else{
            favButton.image = UIImage(named: "Heartno.png")
        }
    }
}
