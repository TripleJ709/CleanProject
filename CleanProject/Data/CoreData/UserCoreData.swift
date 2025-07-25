//
//  UserCoreData.swift
//  CleanProject
//
//  Created by 장주진 on 7/13/25.
//

import Foundation
import CoreData

public protocol UserCoreDataProtocol {
    func getFavoritUsers() -> Result<[UserListItem], CoreDataError>
    func saveFavoritUser(user: UserListItem) -> Result<Bool, CoreDataError>
    func deleteFavoritUser(userID: Int) -> Result<Bool, CoreDataError>
}

public struct UserCoreData: UserCoreDataProtocol {
    private let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    public func getFavoritUsers() -> Result<[UserListItem], CoreDataError> {
        let fetchRequest: NSFetchRequest<FavoriteUser123123> = FavoriteUser123123.fetchRequest()
        do {
            let result = try viewContext.fetch(fetchRequest)
            let userList: [UserListItem] = result.compactMap { favoriteUser in
                guard let login = favoriteUser.login,
                      let imageURL = favoriteUser.imageURL else { return nil }
                return UserListItem(id: Int(favoriteUser.id), login: login, imageURL: imageURL)
            }
            return .success(userList)
        } catch {
            return .failure(.readError(error.localizedDescription))
        }
    }
    
    public func saveFavoritUser(user: UserListItem) -> Result<Bool, CoreDataError> {
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteUser", in: viewContext) else { return .failure(.entityNotFound("FavoriteUser")) }
        let userObject = NSManagedObject(entity: entity, insertInto: viewContext)
        userObject.setValue(user.id, forKey: "id")
        userObject.setValue(user.login, forKey: "login")
        userObject.setValue(user.imageURL, forKey: "imageURL")
        
        do {
            try viewContext.save()
            return .success(true)
        } catch {
            return .failure(.saveError(error.localizedDescription))
        }
    }
    
    public func deleteFavoritUser(userID: Int) -> Result<Bool, CoreDataError> {
        let fetchRequest: NSFetchRequest<FavoriteUser123123> = FavoriteUser123123.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", userID)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            result.forEach { favoriteUser in
                viewContext.delete(favoriteUser)
            }
            try viewContext.save()
            return .success(true)
        } catch {
            return .failure(.deleteError(error.localizedDescription))
        }
    }
    
    
}
