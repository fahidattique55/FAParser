//
//  ViewController.swift
//  FAParser
//
//  Created by Fahid Attique on 24/02/2017.
//  Copyright © 2016 Fahid Attique. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        runFAParserSample()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Search Movie API call
    
    private func runFAParserSample(){
        
        //  load movie data from User Defaults if exist
        var movie1:Movie? = Movie.loadArchivedMovie()
        
        if movie1 == nil {
            movie1 = Movie()
        }
        
        movie1?.searchMovie(success: { (response:Any?) in
            
            //  Get movie object from JSON Response of search Movie API call
            let movie1:Movie? = Movie.objectfrom(json: response)
            
            
            //   Archive movie data in User Defaults
            if let movieToArchive = movie1{
                Movie.archiveMovie(movieToArchive)
            }
        })
        
        let dictFormat :[String: Any] = (movie1?.toDictionary())!
        
        print(dictFormat.jsonString(prettify: true)!)
    }
}


