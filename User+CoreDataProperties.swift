//
//  User+CoreDataProperties.swift
//  SWHacks17
//
//  Created by Jaswant Pakki on 3/11/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }


}
