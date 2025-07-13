//
//  UserListUsecase.swift
//  CleanProject
//
//  Created by 장주진 on 7/12/25.
//

import Foundation

public protocol UserListUsecaseProtocol {
    func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError>
    func getFavoritUsers() -> Result<[UserListItem], CoreDataError>
    func saveFavoritUser(user: UserListItem) -> Result<Bool, CoreDataError>
    func deleteFavoritUser(userID: Int) -> Result<Bool, CoreDataError>
    func checkFavoriteState(fetchUsers: [UserListItem], favoriteUsers: [UserListItem]) -> [(user: UserListItem, isFavorite: Bool)]
    func converListToDictionary(favoriteUsers: [UserListItem]) -> [String: [UserListItem]]
}

public struct UserListUsecase: UserListUsecaseProtocol {
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError> {
        await repository.fetchUser(query: query, page: page)
    }
    
    public func getFavoritUsers() -> Result<[UserListItem], CoreDataError> {
        repository.getFavoritUsers()
    }
    
    public func saveFavoritUser(user: UserListItem) -> Result<Bool, CoreDataError> {
        repository.saveFavoritUser(user: user)
    }
    
    public func deleteFavoritUser(userID: Int) -> Result<Bool, CoreDataError> {
        repository.deleteFavoritUser(userID: userID)
    }
    
    public func checkFavoriteState(fetchUsers: [UserListItem], favoriteUsers: [UserListItem]) -> [(user: UserListItem, isFavorite: Bool)] {
        let favoriteSet = Set(favoriteUsers)
        return fetchUsers.map { user in
            if favoriteSet.contains(user) {
                return (user: user, isFavorite: true)
            } else {
                return (user: user, isFavorite: false)
            }
        }
    }
    
    public func converListToDictionary(favoriteUsers: [UserListItem]) -> [String : [UserListItem]] {
        favoriteUsers.reduce(into: [String : [UserListItem]]()) { dict, user in
            if let firstString = user.login.first {
                let key = String(firstString).uppercased()
                dict[key, default: []].append(user)
            }
        }
    }
}

