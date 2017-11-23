//
//  Bowtie+CoreDataProperties.swift
//  CoreData_Swift
//
//  Created by 韩承海 on 2017/11/22.
//  Copyright © 2017年 韩承海. All rights reserved.
//
//

import Foundation
import CoreData


extension Bowtie {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bowtie> {
        return NSFetchRequest<Bowtie>(entityName: "Bowtie")
    }
}
