//
//  UserSession.swift
//  CleanProject
//
//  Created by 장주진 on 7/13/25.
//

import Foundation
import Alamofire

public protocol SessionProtocol {
    func request(_ convertible: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> DataRequest
}

class UserSession: SessionProtocol {
    private let session: Session
    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        self.session = Session(configuration: config)
    }
    
    func request(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) -> DataRequest {
        session.request(convertible, method: method, parameters: parameters, headers: headers)
    }
}
