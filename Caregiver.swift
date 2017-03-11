//
//  Caregiver+CoreDataClass.swift
//  SWHacks17
//
//  Created by Jaswant Pakki on 3/11/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import CoreData


public class Caregiver: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var phoneNumber: String?
}
