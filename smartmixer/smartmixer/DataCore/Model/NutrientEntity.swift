//
//  NutrientEntity.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/10/1.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(NutrientEntity)

class NutrientEntity: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var nameEng: String
    @NSManaged var thumb: String
    @NSManaged var desc: String

}
