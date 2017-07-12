//
//  Movie.swift
//  FAParser
//
//  Created by Fahid Attique on 24/02/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit



/*  Closures  */

typealias SuccessClosure = (_ response: Any?) -> Void
typealias FailureClosure = (_ error: Error?) -> Void




//  Inheriting from FAAutoCode class to add archiving capability to Song object with out implemention of NSCoding protocols code. FAAutoCode will auto implement the work for you.

class Song: FAAutoCode {
    
    
    //  Properties should have same name as of keys in JSON Response
    
    var title :String = ""
    var singer :String = ""
    
    
    
    
    override init() {
        super.init()
    }
    
    // MARK: NSCoding
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: KVC
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if let aVlaue = value {
            super.setValue(aVlaue, forKey: key)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("This class is not key-value-compliant for key: \(key) & value : \(String(describing: value))")
    }
}

 /*extension Song: CustomReflectable { /* for custom key reprenstation implement CustomReflectable protocol and assign DictionaryLiteral to customMirror object available in Mirrir class */
 
 var customMirror: Mirror {
 let children = DictionaryLiteral<String, Any>(dictionaryLiteral:
 ("head", self.title), ("singer", self.singer))
 
 
 let mirror = Mirror.init(Song.self, children: children, displayStyle: Mirror.DisplayStyle.class, ancestorRepresentation: .suppressed)
 
 return mirror
 }
 }
*/


//  Inheriting from FAAutoCode class to add archiving capability to Movie object with out implemention of NSCoding protocols code. FAAutoCode will auto implement the work for you.


class Movie: FAAutoCode, AZJSONable {
    
    
    //  Properties should have same name as of keys in JSON Response
    
    var Title :String = ""
    var Year  = 2016
    var Rated :String = ""
    var Released :String = ""
    var Runtime :String = ""
    var Genre :String = ""
    var Director :String = ""
    var Writer :String = ""
    var Actors :String = ""
    var Plot :String = ""
    var Language :String = ""
    var Country :String = ""
    var Awards :String = ""
    var Poster :String = ""
    var Metascore :String = ""
    var imdbRating :String = ""
    var imdbVotes :String = ""
    var imdbID :String = ""
    var type :String = ""
    var Response :String = ""
    
    var bestSong:Song? = nil
    var allSongs: Array<Song>? = nil
    
    
    
    override init() {
        super.init()
    }
    
    
    // MARK: NSCoding
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    // MARK: KVC
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if let aVlaue = value {
            
            if key == "bestSong" {
                bestSong = Song.objectfrom(json: value)!
            }
            else if key == "allSongs" {
                allSongs = Song.objectsfrom(jsonArray: value as! Array)
            }
            else{
                super.setValue(aVlaue, forKey: key)
            }
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("This class is not key-value-compliant for key: \(key) & value : \(String(describing: value))")
    }
    
    
    
    
    //  Archiving in UserDefaults
    static func archiveMovie(_ movie:Movie){
        
        let data = NSKeyedArchiver.archivedData(withRootObject:movie)
        UserDefaults.standard.set(data, forKey: "movie")
        UserDefaults.standard.synchronize()
    }
    
    
    //  Un-Archiving from UserDefaults
    
    static func loadArchivedMovie() -> Movie?{
        
        var movie:Movie? = nil
        if let data = UserDefaults.standard.value(forKey: "movie") {
            movie = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! Movie?
        }
        return movie
    }
    
    
    //  Search Movie API call
    
    func searchMovie(success:@escaping SuccessClosure){
        
        let bestSongJSON:Dictionary = ["title":"Beautiful","singer":"eminem"]
        
        let song1:Dictionary = ["title":"song 1","singer":"singer 1"]
        let song2:Dictionary = ["title":"song 2","singer":"singer 2"]
        let song3:Dictionary = ["title":"song 3","singer":"singer 3"]
        
        
        var allSongsJSON:Array<Dictionary<String, Any>> = Array()
        allSongsJSON.append(song1)
        allSongsJSON.append(song2)
        allSongsJSON.append(song3)
        
        
        //  Creating Dummy JSON object as response of API call
        
        let JSON:Dictionary<String, Any> = [
            
            //  Keys & values
            
            "Actors" : "Michael Keaton, Jack Nicholson, Kim Basinger, Robert Wuhl",
            "Awards" : "Won 1 Oscar. Another 9 wins & 22 nominations.",
            "Country" : "USA, UK",
            "Director" : "Tim Burton",
            "Genre" : "Action, Adventure",
            "Language" : "English, French",
            "Metascore" : "69",
            "Plot" : "The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker.",
            "Poster" : "https://images-na.ssl-images-amazon.com/images/M/MV5BMTYwNjAyODIyMF5BMl5BanBnXkFtZTYwNDMwMDk2._V1_SX300.jpg",
            "Rated" : "PG-13",
            "Released" : "23 Jun 1989",
            "Response" :  "True",
            "Runtime" : "126 min",
            "Title" : "Batman",
            "Type" : "movie",
            "Writer" : "Bob Kane (Batman characters), Sam Hamm (story), Sam Hamm (screenplay), Warren Skaaren (screenplay)",
            "Year" : "1989",
            "imdbID" : "tt0096895",
            "imdbRating" : "7.6",
            "imdbVotes" : "277,267",
            
            
            //  Simple JSON
            
            "bestSong" : bestSongJSON,
            
            
            //  JSON Array
            
            "allSongs" : allSongsJSON
        ]
        
        success(JSON)
    }
}
