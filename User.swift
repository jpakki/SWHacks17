//
//  User+CoreDataClass.swift
//  SWHacks17
//
//  Created by Jaswant Pakki on 3/11/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import CoreData


public class User: NSManagedObject {
    @NSManaged public var address: String?
    @NSManaged public var long: Float
    @NSManaged public var lat: Float
    @NSManaged public var name: String?
    @NSManaged public var radius: Int16
}
