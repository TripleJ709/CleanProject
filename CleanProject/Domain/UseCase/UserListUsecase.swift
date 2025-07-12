//
//  UserListUsecase.swift
//  CleanProject
//
//  Created by 장주진 on 7/12/25.
//

import Foundation

public protocol UserListUsecaseProtocol {
    func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError>
    func getFavoritUsers() -> Result<UserListItem, CoreDataError>
    func saveFavoritUser(user: UserListItem) -> Result<Bool, CoreDataError>
    func deleteFavoritUser(userID: Int) -> Result<Bool, CoreDataError>
}

public struct UserListUsecase: UserListUsecaseProtocol {
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError> {
        await repository.fetchUser(query: query, page: page)
    }
    
    public func getFavoritUsers() -> Result<UserListItem, CoreDataError> {
        repository.getFavoritUsers()
    }
    
    public func saveFavoritUser(user: UserListItem) -> Result<Bool, CoreDataError> {
        repository.saveFavoritUser(user: user)
    }
    
    public func deleteFavoritUser(userID: Int) -> Result<Bool, CoreDataError> {
        repository.deleteFavoritUser(userID: userID)
    }
    
    
}

