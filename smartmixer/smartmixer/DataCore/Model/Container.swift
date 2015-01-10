//
//  Container.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/10/1.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(Container)
class Container: NSManagedObject {

    @NSManaged var des: String
    @NSManaged var id: NSNumber
    @NSManaged var updatetime: NSDate
    @NSManaged var name: String
    @NSManaged var nameEng: String
    @NSManaged var ihave: NSNumber
    @NSManaged var thumb: String
    @NSManaged var unitId: NSNumber
    @NSManaged var volume: NSNumber
    @NSManaged var createtime: NSDate

}
