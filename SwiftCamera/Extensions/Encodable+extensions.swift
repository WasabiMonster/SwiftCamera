//
//  Encodable+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 3/9/22.
//

import Foundation

extension Encodable {
	var dictionary: [String: Any] {
		guard let data = try? JSONEncoder().encode(self) else { return [:] }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
	}

	func asDictionary() throws -> [String: Any] {
		let data = try JSONEncoder().encode(self)
		guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
			throw NSError()
		}
		return dictionary
	}
}

extension Encodable {
    func hasKey(for path: String) -> Bool {
        return Mirror(reflecting: self).children.contains { $0.label == path }
    }
    
    func typeOf(for path: String) -> Any.Type? {
        return type(of: Mirror(reflecting: self).children.first { $0.label == path }?.value)
    }
    
    func value(for path: String) -> Any? {
        return Mirror(reflecting: self).children.first { $0.label == path }?.value
    }

}

// Alternative using JSON Serialization:
/*
 extension Encodable {
     func hasKey(for path: String) -> Bool {
         return dictionary?[path] != nil
     }
     func value(for path: String) -> Any? {
         return dictionary?[path]
     }
     var dictionary: [String: Any]? {
         return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any]
     }
 }
*/
