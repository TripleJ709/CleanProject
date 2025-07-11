//
//  CoreDataError.swift
//  CleanProject
//
//  Created by 장주진 on 7/11/25.
//

import Foundation

public enum CoreDataError: Error {
    case entityNotFound(String)
    case saveError(String)
    case readError(String)
    case deleteError(String)
    
    public var description: String {
        switch self {
        case .entityNotFound(let objectName):
            "객체를 찾을 수 없습니다 \(objectName)"
        case .saveError(let msg):
            "객체 저장 실패 \(msg)"
        case .readError(let msg):
            "객체 조회 에러 \(msg)"
        case .deleteError(let msg):
            "객체 삭제 에러 \(msg)"
        }
    }
}
