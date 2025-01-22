//
//  Decode.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 21/1/25.
//

import Foundation

func decode<T: Decodable>(_: T.Type, from data: Data) -> T? {
    do {
        let decodedObject = try JSONDecoder().decode(T.self, from: data)
        return decodedObject
    } catch let DecodingError.dataCorrupted(context) {
        print("❌ Data corrupted: \"\(context.debugDescription)\"... 📝")
    } catch let DecodingError.keyNotFound(key, context) {
        print("❌ Key '\(key)' not found: \(context.debugDescription)... 📝")
    } catch let DecodingError.valueNotFound(value, context) {
        print("❌ Value '\(value)' not found: \(context.debugDescription)... 📝")
    } catch let DecodingError.typeMismatch(type, context) {
        print("❌ Type '\(type)' mismatch: \(context.debugDescription)... 📝")
    } catch {
        print("❌ Unknown error: \(error)... 📝")
    }
    return nil
}
