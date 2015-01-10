//
//  Ingridient.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/10/1.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(Ingridient)
class Ingridient: NSManagedObject {

    @NSManaged var alcohol: NSNumber
    @NSManaged var buylink: String
    @NSManaged var categoryId: NSNumber
    @NSManaged var density: NSNumber
    @NSManaged var desc: String
    @NSManaged var id: NSNumber
    @NSManaged var ihave: NSNumber
    @NSManaged var updatetime: NSDate
    @NSManaged var name: String
    @NSManaged var nameEng: String
    @NSManaged var color: NSNumber
    @NSManaged var thumb: String
    @NSManaged var unitId: NSNumber
    @NSManaged var calorie: NSNumber
    @NSManaged var fe: NSNumber
    @NSManaged var protein: NSNumber
    @NSManaged var fat: NSNumber
    @NSManaged var carbohydrates: NSNumber
    @NSManaged var calcium: NSNumber
    @NSManaged var salt: NSNumber
    @NSManaged var createtime: NSDate
    @NSManaged var price: String
    @NSManaged var fiber: NSNumber
    @NSManaged var randiship: RecipeIngrdient

}
