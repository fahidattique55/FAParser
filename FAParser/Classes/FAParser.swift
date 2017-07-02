//
//  FAParser.swift
//  Pods
//
//  Created by Fahid Attique on 25/02/2017.
//
//

import Foundation




/*  Extension NSObject  */


public extension NSObject {
    
    
    /// This function returns the array of names of stored properties of an object
    
    func allKeys() -> Array<String>? {
        
        var keys:Array<String> = Array()
        let mirror = Mirror(reflecting: self)
        for (_, attr) in mirror.children.enumerated() {
            if let property_name = attr.label as String! {
                keys.append(property_name)
            }
        }
        return keys
    }
    
    
    
    /// This function returns a dictionary of all keys and values of an object
    
    func dictionaryRepresentation() -> [String:Any?]? {
        
        var dictionary:Dictionary<String,Any?> = Dictionary<String,Any?>()
        let mirror = Mirror(reflecting: self)
        for (_, attr) in mirror.children.enumerated() {
            
            if let property_name = attr.label as String! {
                dictionary[property_name] = attr.value
            }
        }
        return dictionary
    }
    
    
    
    
    /// This function returns an object of template type 'T', mapped with a dictionary using Key value coding (KVC).
    
    class func objectfrom<T:AnyObject>(json: Any?) -> T? {
        
        var object:AnyObject? = nil
        if json != nil {
            if let data = json as? [String : Any] {
                
                //  This is the case where <dictionary> will always be a JSON
                object = self.init()
                object?.setValuesForKeys(data)
            }
            else{
                //  This is the case where <dictionary> can be a custom object of type AnyObject
                object = json as AnyObject?
            }
        }
        return object as? T
    }
    
    
    
    
    /// This function returns an array of objects of template type 'T', mapped with an array using function named as objectfrom<T:AnyObject>(dictionary: Any?) -> T?.
    
    class func objectsfrom<T:AnyObject>(jsonArray: Array<Any>) -> [T] {
        
        var objects:Array<T> = Array()
        for value:Any in jsonArray{
            if let object:T = objectfrom(json: value) {
                objects.append(object)
            }
        }
        return objects
    }
}






//  --------------------------------------------------------------------------------

/*  FAAutoCode  */



/// Inherit your business specific modal classes with FAAutoCode class, in case you want to archieve them in NSUserDefaults. It will save your time by smart and auto implementation of NSCoding protocols. This Class encodes and decodes your modal classes object using its dictionary representation.


open class FAAutoCode: NSObject, NSCoding {
    
    
    public override init() {
        super.init()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init()
        
        if let keys = allKeys() {
            
            for key:String in keys{
                
                let value = aDecoder.decodeObject(forKey: key) as? NSObject
                
                if !(value is NSNull) {
                    
                    setValue(value , forKey:key)
                }
            }
        }
    }
    
    public func encode(with aCoder: NSCoder) {
        
        if let dictionary = dictionaryRepresentation() {
            
            for (key,value) in dictionary{
                aCoder.encode(value, forKey:key)
            }
        }
    }
}
