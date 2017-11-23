//
//  Bowtie+CoreDataClass.swift
//  CoreData_Swift
//
//  Created by 韩承海 on 2017/11/22.
//  Copyright © 2017年 韩承海. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Bowtie)
public class Bowtie: NSManagedObject {
    @NSManaged public var imageData: NSData?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var lastWorn: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var photoData: NSData?
    @NSManaged public var tintColor: NSObject?
}
