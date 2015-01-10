//
//  Nutrients.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/10/1.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(Nutrients)
class Nutrients: NSManagedObject {

    @NSManaged var nutCategoryId: NSNumber
    @NSManaged var ingridientId: NSNumber
    @NSManaged var amount: NSNumber

}
