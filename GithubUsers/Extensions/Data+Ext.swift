//
//  Data+Ext.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 21/1/25.
//

import Foundation

extension Data {
    func toJSON() -> [String: Any]? {
        if isEmpty {
            return nil
        }
        return try? JSONSerialization.jsonObject(
            with: self,
            options : .allowFragments) as? [String: Any]
    }
}
