//
//  FavoriteUser+CoreDataProperties.swift
//  CleanProject
//
//  Created by 장주진 on 7/13/25.
//
//

import Foundation
import CoreData


extension FavoriteUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteUser> {
        return NSFetchRequest<FavoriteUser>(entityName: "FavoriteUser")
    }

    @NSManaged public var id: Int32
    @NSManaged public var login: String?
    @NSManaged public var imageURL: String?

}

extension FavoriteUser : Identifiable {

}
