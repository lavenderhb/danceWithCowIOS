//
//  KSet+CoreDataProperties.swift
//  dancewithcow
//
//  Created by 雷伊潇 on 17/6/15.
//  Copyright © 2017年 org.com.abc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension KSet {

    @NSManaged var name: String?
    @NSManaged var desc: String?
    @NSManaged var isUse: String?

}
