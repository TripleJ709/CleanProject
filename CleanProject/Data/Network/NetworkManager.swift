//
//  NetworkManager.swift
//  CleanProject
//
//  Created by 장주진 on 7/13/25.
//

import Foundation
import Alamofire

public class NetworkManager {
    private let session: SessionProtocol
    init(session: SessionProtocol) {
        self.session = session
    }
    
    private let tokenHeader: HTTPHeaders = {
        guard let githubToken = Secrets.shared.value(for: "GitHubAPIToken") else  {
            print("github 토큰 없음")
            return HTTPHeaders()
        }
        let tokenHeader = HTTPHeader(name: "Authorization", value: "Bearer \(githubToken)")
        return HTTPHeaders([tokenHeader])
    }()
    
    func fetchData<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters?) async -> Result<T, NetworkError> {
        guard let url = URL(string: url) else {
            return .failure(.urlError)
        }
        
        let result = await session.request(url, method: method, parameters: parameters, headers: tokenHeader).serializingData().response
        if let error = result.error { return .failure(.requestFailed(error.localizedDescription))}
        guard let data = result.data else { return .failure(.dataNil) }
        guard let response = result.response else { return .failure(.invalid) }
        if 200..<400 ~= response.statusCode {
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                return .success(data)
            } catch  {
                return .failure(.failToDecode(error.localizedDescription))
            }
        } else {
            return .failure(.serverError(response.statusCode))
        }
    }
}
