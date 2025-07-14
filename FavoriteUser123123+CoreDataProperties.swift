//
//  FavoriteUser123123+CoreDataProperties.swift
//  CleanProject
//
//  Created by 장주진 on 7/14/25.
//
//

import Foundation
import CoreData


extension FavoriteUser123123 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteUser123123> {
        return NSFetchRequest<FavoriteUser123123>(entityName: "FavoriteUser123123")
    }

    @NSManaged public var id: Int16
    @NSManaged public var imageURL: String?
    @NSManaged public var login: String?

}

extension FavoriteUser123123 : Identifiable {

}
