//
//  WMATAService.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/26/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import Foundation

enum Path: String {
    case RailLines = "jLines/"
}

class WMATAService {
    
    private static let baseURLString = "https://api.wmata.com/Rail.svc/json/"
    private static let pList = NSBundle.mainBundle().pathForResource("keys", ofType: "plist")
    private static let plistContents = NSDictionary(contentsOfFile: pList!) as! [String: AnyObject]
    
    private class func wmataURL(path path: Path) -> NSURL {
        
        let url = baseURLString.stringByAppendingString(path.rawValue)
        let components = NSURLComponents(string: url)
        var queryItems = [NSURLQueryItem]()
        
        let APIKey = String(plistContents["WmataAPIKey"]!)
        let baseParams = [
            "api_key": APIKey
        ]
        
        for(key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        components!.queryItems = queryItems
        return components!.URL!
    }
    
    class func getRailLines() -> NSURL {
        return wmataURL(path: .RailLines)
    }
}
