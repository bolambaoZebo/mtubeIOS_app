//
//  CacheManager.swift
//  mTube
//
//  Created by DNA-Z on 7/1/20.
//  Copyright © 2020 DNA-Z. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var cache = [String:Data]()
    
    static func setVideoCache(_ url:String, _ data:Data?){
        
        //store the image data and use the url as the key
        cache[url] = data
    }
    
    static func getVideo(_ url:String) -> Data? {
        
        //try getting the data for specified url
        return cache[url]
    }
    
}
