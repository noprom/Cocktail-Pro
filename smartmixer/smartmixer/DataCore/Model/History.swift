//
//  History.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/10/1.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(History)
class History: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var type: NSNumber
    @NSManaged var refid: NSNumber
    @NSManaged var name: String
    @NSManaged var thumb: String
    @NSManaged var addtime: NSDate

}
