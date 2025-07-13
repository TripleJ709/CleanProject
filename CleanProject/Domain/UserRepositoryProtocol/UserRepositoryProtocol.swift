//
//  UserRepositoryProtocol.swift
//  CleanProject
//
//  Created by 장주진 on 7/12/25.
//

import Foundation

public protocol UserRepositoryProtocol {
    func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError>
    func getFavoritUsers() -> Result<[UserListItem], CoreDataError>
    func saveFavoritUser(user: UserListItem) -> Result<Bool, CoreDataError>
    func deleteFavoritUser(userID: Int) -> Result<Bool, CoreDataError>
}
