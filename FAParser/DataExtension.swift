//
//  Dictionary+Additions.swift
//  Pods
//
//  Created by Muhammad Afroz on 5/8/17.
//
//

import Foundation
import UIKit

extension Dictionary {
    
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    public mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0)})
    }
    
    public func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    public func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options)
        return jsonData?.string(encoding: .utf8)
    }
    
}
// MARK: - Methods
public extension Data {
    
    public func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
    
}
