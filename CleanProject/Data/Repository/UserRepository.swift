//
//  UserRepository.swift
//  CleanProject
//
//  Created by 장주진 on 7/13/25.
//

import Foundation

public struct UserRepository: UserRepositoryProtocol {
    
    private let coreData: UserCoreDataProtocol
    private let network: UserNetworkProtocol
    init(coreData: UserCoreDataProtocol, network: UserNetworkProtocol) {
        self.coreData = coreData
        self.network = network
    }
    
    public func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError> {
        return await network.fetchUser(query: query, page: page)
    }
    
    public func getFavoritUsers() -> Result<[UserListItem], CoreDataError> {
        return coreData.getFavoritUsers()
    }
    
    public func saveFavoritUser(user: UserListItem) -> Result<Bool, CoreDataError> {
        return coreData.saveFavoritUser(user: user)
    }
    
    public func deleteFavoritUser(userID: Int) -> Result<Bool, CoreDataError> {
        return coreData.deleteFavoritUser(userID: userID)
    }
    
}
