//
//  Secrets.swift
//  CleanProject
//
//  Created by 장주진 on 7/13/25.
//

import Foundation

class Secrets {
    static let shared = Secrets()

    private var values: [String: Any] = [:]

    private init() {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let data = FileManager.default.contents(atPath: path),
           let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] {
            self.values = plist
        }
    }

    func value(for key: String) -> String? {
        return values[key] as? String
    }
}
