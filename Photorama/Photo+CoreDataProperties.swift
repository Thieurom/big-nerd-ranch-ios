//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by Doan Le Thieu on 4/10/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var title: String?
    @NSManaged public var remoteURL: NSURL?
    @NSManaged public var photoID: String?
    @NSManaged public var dateTaken: NSDate?

}
